args = {...}
mydir = "/sfcc"
github = "https://raw.githubusercontent.com/ItsSurface/SFCC/main/"

function download(ghpath, path)
    shell.run("wget", github .. ghpath .. ".lua", mydir .. path)
end

fs.delete(mydir)
fs.makeDir(mydir)
download("testmine", "/testmine")