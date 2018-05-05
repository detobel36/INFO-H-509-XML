declare namespace custom = "http://example.com";

declare function custom:generateTag($author as xs:string, $coAuthor as xs:string, $distance as xs:integer)
{
    let $test := 1
    return <distance author1="{$author}" author2="{$coAuthor}" distance="{$distance}" />
};


declare function custom:printCoAuthor($author as xs:string, $distance as xs:integer, $allAuthor, $allContext)
{
    for $coAuthor in distinct-values($allContext[author=$author]/author)
    where not($coAuthor = $allAuthor) and not($coAuthor = $author)
        return <distance author1="{$author}" author2="{$coAuthor}" distance="{$distance}" />
    return <test/>
}

declare function custom:getTree($author as xs:string, $intervalAuthor as xs:string, $distance as xs:integer, 
    $allAuthor, $allContext)
{
    let $newDistance := $distance + 1
    let $newAllAuthor := distinct-values(($allAuthor, $allContext[author=$intervalAuthor]/author))
    for $coAuthor in distinct-values($allContext[author=$intervalAuthor]/author)
    where not($coAuthor = $author) and not($coAuthor = $allAuthor)
        return (<ici><distance>{$newDistance}</distance><all>{$allAuthor}</all><newAll>{$newAllAuthor}</newAll></ici>,
            custom:generateTag($author, $coAuthor, $newDistance),
            custom:getTree($author, $coAuthor, $newDistance, $newAllAuthor, $allContext))
};

<distances>
{
    for $author in distinct-values(//author)
        return custom:printCoAuthor($author, 0, "", //*)
}
</distances>



