declare namespace custom = "http://example.com";

declare function custom:generateTag($author as xs:string, $coAuthor as xs:string, $distance as xs:integer)
{
    let $test := 1
    return <distance author1="{$coAuthor}" author2="{$author}" distance="{$distance}" />
};

declare function custom:getTree($author as xs:string, $intervalAuthor as xs:string, $distance as xs:integer, $allContext)
{
    let $newDistance := $distance + 1
    for $coAuthor in distinct-values($allContext[author=$intervalAuthor]/author)
    where $coAuthor != $author and $coAuthor != $intervalAuthor
        return (custom:getTree($author, $coAuthor, $newDistance, $allContext except $allContext[author=$intervalAuthor]),
                custom:generateTag($author, $coAuthor, $newDistance))
};

<distances>
{
    for $author in distinct-values(//author)
        return custom:getTree($author, $author, 0, //*)
}
</distances>