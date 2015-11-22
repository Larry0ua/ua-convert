import groovy.xml.QName
import groovy.xml.XmlUtil

def t = System.currentTimeMillis()
new Replacements('replacements.txt').renameStreets('d:/Chernivtsi.osm', "d:/Chernivtsi_new.osm")
println System.currentTimeMillis() - t

class Replacements {
    def replacements


    Replacements(String fileName) {
        replacements = [:]
        new File(fileName).splitEachLine('\t', {
            if (it[0] && it[1]) {
                replacements[it[0]] = it[1]
            }
        })
    }

    def stats = [:].withDefault {0}

    String replace(String oldName) {
        String key = replacements.keySet().find { k -> oldName =~ k }
        if (key) {
            stats[key]++;
            replacements[key]
        } else {
            oldName
        }
    }
    boolean isForReplacement(def name) {
        replacements.keySet().any{ k -> name =~ k}
    }

    Map<String,Set> deps = [:].withDefault { new HashSet() }

    private dependencies(Node node) {
        if (node.name() == 'way') {
            deps['node'] += node.nd*.@ref
        } else if (node.name() == 'relation') {
            deps['way'] += node.member.findAll { it.@type == 'way' }*.@ref
            deps['node'] += node.member.findAll { it.@type == 'node' }*.@ref
            deps['relation'] += node.member.findAll { it.@type == 'relation' }*.@ref
        }
    }

    void renameStreets(String inputFileName, String outputFileName) {

        def root = new XmlParser().parse(inputFileName)

        root.'*'.findAll {
            it.tag.any {
                isForReplacement(it.@v)
            }
        }.each {Node node ->
            // associatedStreet/street relations, highways: move name to old_name, name:xx to old_name:xx, add name and name:uk from new
            if (node.tag.any{it.@v == 'street' || it.@v == 'associatedStreet'}
                    || node.tag.any {it.@k == 'highway' && it.@v in ['motorway','trunk','primary','secondary','tertiary',
                                                                     'unclassified','residential','service','living_street',
                                                                     'motorway_link','trunk_link','primary_link',
                                                                     'secondary_link','tertiary_link']}
            ) {
                String name = node.tag.find{it.@k=='name'}.@v
                if (isForReplacement(name)) {
                    def replaced = replace(name)
                    node.tag.each {
                        if (it.@k.startsWith('name')) {
                            it.@k = 'old_' + it.@k
                        }
                    }
                    node.appendNode (new QName("tag"), [k:'name', v:replaced])
                    node.appendNode (new QName("tag"), [k:'name:uk', v:replaced])
                    node.@action = 'modify'
                    dependencies(node)
                }
            }

            // addr:street - change to new name only
            node.tag.each { t ->
                if (t.@k == 'addr:street' && isForReplacement(t.@v)) {
                    t.@v = replace(t.@v)
                    node.@action = 'modify'
                    dependencies(node)
                }
            }
        }
        // relation -> relation
        Set depRels = new HashSet(deps['relation'])
        while (depRels) {
            def tempRels = new HashSet()
            root.relation.findAll { it.@id in depRels }.each { Node it ->
                dependencies(it)
                tempRels << it.member.findAll { it.@type == 'relation' }*.@ref
            }
            depRels = tempRels - depRels
        }
        // way -> node
        root.way.findAll { it.@id in deps['way']}.each { Node it ->
            dependencies(it)
        }

        def toRemove = root.findAll{!it.@action && !deps[it.name()].contains(it.@id)}
        toRemove.each{root.remove(it)}
        XmlUtil.serialize(root, new FileOutputStream(outputFileName))

        stats.each {
            println "$it.key : $it.value"
        }
        println "Not found:"
        println replacements.keySet() - stats.keySet()
    }
}

