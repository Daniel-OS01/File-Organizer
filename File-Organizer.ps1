function get-destbytype($ext) {
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
# 
$dirtyfolder = "D:\Downloads\"
$org = $dirtyfolder

ls $dirtyfolder/* | ? { !$_.PSIsContainer } | % {
    $ext = $_.extension
    $dest = "$($org)\$(get-destbytype $ext)"
    if (! (Test-Path -path $dest ) ) {
        New-Item $dest -type directory
    }
    Move-Item -Path $_.FullName -Destination $dest -Force
}