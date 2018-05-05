declare namespace custom = "http://example.com";


declare function custom:getListAuthorDistance($allContext, $distance as xs:integer, $intermediateAuteur as xs:string)
{
    if($distance > 0) then (
        for $newCoAuteur in distinct-values($allContext[author=$intermediateAuteur]/author)
        where not($intermediateAuteur = $newCoAuteur)
            return ($newCoAuteur, custom:getListAuthorDistance($allContext, ($distance - 1), $newCoAuteur))
    )
    else (
        $intermediateAuteur
    )
};

declare function custom:authorInASpecificDistance($author as xs:string, $allContext, $distance as xs:integer)
{
    let $previousCheck := distinct-values(custom:getListAuthorDistance($allContext, ($distance - 1), $author))
    let $currentCheck := distinct-values(custom:getListAuthorDistance($allContext, $distance, $author))
    for $coAuteur in $currentCheck[not(.=$previousCheck)]
    where not($coAuteur = $author)
        return <distance author1="{$author}" author2="{$coAuteur}" distance="{$distance}" />
};


declare function custom:loopDistance($author as xs:string, $allContext)
{
    for $i at $index in distinct-values($allContext//author)
    return custom:authorInASpecificDistance($author, $allContext, $index)
};

<distances>
{
    for $author in distinct-values(//author)
        return custom:loopDistance($author, //*)
}
</distances>