mydir = "/sfcc"
github = "https://raw.githubusercontent.com/ItsSurface/SFCC/main/"

function download(ghpath, path)
    shell.run("wget", github .. ghpath .. ".lua", mydir .. path)
end

fs.delete(mydir)
fs.makeDir(mydir)
download("mine/test", "/mine/test")
download("mine/floor", "/mine/floor")
download("mine/harvest", "/mine/harvest")
download("util/composter", "/util/composter")