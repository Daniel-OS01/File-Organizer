# This function takes the file extension as a parameter and returns the destination type 
function get-destbytype($ext) {
    # Switch statement to check for different file types
    switch ($ext) {
        { $ext -match '(jpg|jpeg|png|gif|bmp|svg|webp)' } { "Photos" }
        { $ext -match '(divx|mpeg|avi|mkv|mp4)' } { "Video" }
        { $ext -match '(js|java|py|class|vbs|jsp)' } { "Code" }
        { $ext -match '(sql|ps1|pl|py|scpt)' } { "Scripts" }
        { $ext -match '(zip|7z|rar|tar|bz2|gz|sig|lz|part)' } { "Compressed" }
        { $ext -match '(doc|docx|pdf|dotx|md)' } { "Documents" }
        { $ext -match '(xls|xlsx|csv)' } { "Excel" }
        { $ext -match '(exe|dll|jar|ear|bat|cmd|msi|vsix)' } { "Applications" }
        { $ext -match '(txt|log|vtt|cc)' } { "Text" }
        { $ext -match '(properties|ini)' } { "Config" }
        { $ext -match '(m4a|mp3)' } { "Audio" }
        { $ext -match '(bib|ris|ini)' } { "References" }
        { $ext -match '(pptx|ppt)' } { "Presentations" }
        { $ext -match '(ipsw|img|iso)' } { "ISO-Images" }
        { $ext -match '(epub|mobi|azw|azw3|iba)' } { "Ebooks" }
        { $ext -match '(htm|html|lnk|php|xml)' } { "Website Related" }
        { $ext -match '(vlt|data|crdownload|msg|torrent)' } { "Other" }
        default { "$ext" }
    }
}
# Store folder path in a variable.
$dirtyfolder = "C:\Users\Dean\Downloads\"
$org = $dirtyfolder

# Store different file types in an array.
$fileTypes = @(".jpg", ".jpeg", ".png", ".gif", ".bmp", ".svg", ".webp", ".divx", ".mpeg", ".avi", ".mkv", ".mp4", ".js", ".java", ".py", ".class", ".vbs", ".jsp", ".sql", ".ps1", ".pl", ".py", ".scpt", ".zip", ".7z", ".rar", ".tar", ".bz2", ".gz", ".sig", ".lz", ".part", ".doc", ".docx", ".pdf", ".dotx", ".md", ".xls", ".xlsx", ".csv", ".exe", ".dll", ".jar", ".ear", ".bat", ".cmd", ".msi", ".vsix", ".txt", ".log", ".vtt", ".cc", ".properties", ".ini", ".m4a", ".mp3", ".bib", ".ris", ".ini", ".pptx", ".ppt", ".ipsw", ".img", ".iso", ".epub", ".mobi", ".azw", ".azw3", ".iba", ".htm", ".html", ".lnk", ".php", ".xml", ".vlt", ".data", ".crdownload", ".msg", ".torrent")

# Get items from the folder and loop through them, checking for matching extensions
Get-ChildItem -Path $dirtyfolder -Recurse | Where-Object { $fileTypes -contains $_.Extension } | ForEach-Object {
    # Get the file extension of each item
    $ext = $_.extension
    # Store the destination type using the get-destbytype function
    $dest = "$($org)\$(get-destbytype $ext)"
    # Check if the destination folder exists
    if (! (Test-Path -path $dest ) ) {
        # Create the destination folder
        New-Item $dest -type directory
    }
    # Move the file to the destination folder
    Move-Item -Path $_.FullName -Destination $dest -Force
}