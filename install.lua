args = {...}
mydir = "/sfcc"
ghpath = "https://raw.githubusercontent.com/SpaceFace16518/SpaceFaceCC/main"


function download(ghpath, path)
    shell.run("wget", ghpath, path)
end