args = {...}
github = "https://raw.githubusercontent.com/ItsSurface/SFCC/main/"

function download(ghpath, path)
    shell.run("wget", github .. ghpath .. ".lua", mydir .. path)
end

fs.delete("/update")
download("update", "/update")

shell.run("/update")