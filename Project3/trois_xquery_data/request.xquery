<authors_coauthors>
{
    for $x in //author
    return <author>
                <name>{data($x)}</name>
                <coauthors number="{count(//*[author=$x]/author)-1}">
                    {//*[author=$x]/author[author=$x]}
                </coauthors>
            </author>
}
</authors_coauthors>