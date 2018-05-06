declare option saxon:output "indent=yes";

<authors_coauthors>
{
    for $author in distinct-values(//author)
    return <author>
                <name>{data($author)}</name>
                <coauthors number="{count(//*[author=$author]/author)-1}">
                {
                    for $coauthor in //*[author=$author]/author[not(.=$author)]
                    return <coauthor>
                            <name>{data($coauthor)}</name>
                            <nb_joint_pubs>{count(//*[author=$author]/author[.=$coauthor])}</nb_joint_pubs>
                        </coauthor>
                }
                </coauthors>
            </author>
}
</authors_coauthors>