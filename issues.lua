require'lfs'

print("Scanning for issues.")
for file in lfs.dir("issues/") do
   file = "issues/"..file
   if lfs.attributes(file, "mode") == "file" then
      print("Found issue, "..file)

      tex.print("\\defineissue{"..file.."}")
    end
end
