fs.delete("/update")
shell.run("wget", "https://raw.githubusercontent.com/ItsSurface/SFCC/main/update.lua", "/update")
shell.run("/update")