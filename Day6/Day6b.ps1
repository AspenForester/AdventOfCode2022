$data = Get-Content -path .\Day6Data.txt

$MarkerLength = 14
for ($i = ($MarkerLength - 1); $i -lt ($data.Length - 1); $i++) {
    $previousfour = $data.Substring(($i-($MarkerLength - 1)),$MarkerLength)
    # write-host $previousfour
    if (($previousfour.ToCharArray() | Select-Object -Unique).count -eq $MarkerLength) {
       return ($i + 1)
    }
}