# use for compile .tex files in the directory

#param(
#[string]$compilename=$(throw "Parameter missing: -name Name,`
#command should be like : .\complie.ps1 xelatex ")
#)

if (-not (Test-Path .\temp))
{
    mkdir temp 
};

if ($null -eq $args[0])
{
# the default tex compiler used for compile .tex
$compilename="xelatex.exe";
}
else
{
$compilename=$args[0]
};

$texfiles=Get-ChildItem -filter *.tex;

foreach ( $texmain in $texfiles)
{
    $compile_command=($compilename + " " + "-halt-on-error" + " " + "-output-directory=temp -shell-escape -interaction=nonstopmode" + " " + $texmain.basename); 

    if (-not (Test-Path -path Get-location -Filter *.bib))
    {
    Invoke-Expression $compile_command  >./log.txt;
    }
    else
    {
    Invoke-Expression $compile_command  >./log.txt;
    bibtex ./temp/($texmain.basename);
    Invoke-Expression $compile_command  >./log.txt;
    Invoke-Expression $compile_command  >./log.txt;
    }
    Copy-Item $(".\temp\" + $texmain.basename + ".pdf") -Destination $(".\" + $texmain.basename + ".pdf")
}

Get-ChildItem * -Include *.aux,*.log -Recurse | Remove-Item ;


Write-Output ------------------------------------------------
Write-Output Compile  finished.
Write-Output ------------------------------------------------

#Copy-Item /Y ".\temp\%FileName%.pdf" ".\%FileName%.pdf"
#Start-Process  " " /max "./%FileName%.pdf"


foreach ( $texmain in $texfiles)
{
    $($compilename + " " + "-output-directory=temp" + " "+ $texmain.basename);  
}

# open all the pdf files in the sumatrapdf.exe, replace it into path of your computers.
&'C:\Program Files\SumatraPDF\SumatraPDF.exe'  (Get-ChildItem | Where-Object Name -Like "*.pdf")

