if ($null -eq $args)
{
# the default tex compiler used for compile .tex
$compilename="xelatex.exe";
}
else
{
$compilename=$args[0]
};

Write-Output $compilename 

Write-Output ( $null -eq $compilename )