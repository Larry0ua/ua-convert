for /r results %%a in (*.img) do 7z a -tzip %%a.zip %%a
for /r results %%a in (*.nm2) do 7z a -tzip %%a.zip %%a
