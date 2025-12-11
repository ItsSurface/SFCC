fs.delete("/update")
shell.run("wget", "https://github.com/ItsSurface/SFCC/raw/refs/heads/main/update.lua", "/update")
shell.run("/update")
