function get-destbytype($ext) {
    switch ($ext) {
        { $ext -match '(jpg|jpeg|png|gif|bmp|svg|webp)' } { "Photos" }
        { $ext -match '(divx|mpeg|avi|mkv|mp4)' } { "Video" }
        { $ext -match '(sql|ps1|pl|scpt|js|java|py|class|vbs|jsp)' } { "Scripts-Code" }
        { $ext -match '(zip|7z|rar|tar|bz2|gz)' } { "Compressed" }
        { $ext -match '(doc|docx|pdf)' } { "Documents" }
        { $ext -match '(xls|xlsx|csv)' } { "Excel" }
        { $ext -match '(exe|dll|jar|ear|bat|cmd|msi)' } { "Applications" }
        { $ext -match '(txt|log)' } { "Text" }
        { $ext -match '(msg)' } { "Miscellaneous" }
        { $ext -match '(properties|xml|ini)' } { "Config" }
        { $ext -match '(m4a|mp3)' } { "Audio" }
        { $ext -match '(bib|ris|ini)' } { "References" }
        { $ext -match '(pptx|ppt)' } { "Presentations" }
        { $ext -match '(ipsw|img|iso|vsix)' } { "ISO-Images" }
        { $ext -match '(epub|img)' } { "Ebooks" }
        { $ext -match '(htm|html|lnk|php)' } { "Website Related" }
        default { "$ext" }
    }
}
# Folder to organize the files in
$dirtyfolder = "F:\Downloads\"
$org = $dirtyfolder

ls $dirtyfolder/* | ? { !$_.PSIsContainer } | % {
    $ext = $_.extension
    $dest = "$($org)\$(get-destbytype $ext)"
    if (! (Test-Path -path $dest ) ) {
        New-Item $dest -type directory
    }
    Move-Item -Path $_.FullName -Destination $dest -Force
}