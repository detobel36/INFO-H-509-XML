declare namespace custom = "http://example.com";


declare function custom:getListAuthorDistance($author as xs:string, $allContext, $distance as xs:integer, $coAuteur as xs:string)
{
    if($distance > 0) then (
        let $newDistance := $distance - 1
        for $newCoAuteur in distinct-values($allContext[author=$coAuteur]/author)
        where not($newCoAuteur = $author) and not($coAuteur = $newCoAuteur)
            return ($newCoAuteur, custom:getListAuthorDistance($author, $allContext, $newDistance, $newCoAuteur))
    )
    else (
        $coAuteur
    )
};

declare function custom:prepareDistanceAuthor($author as xs:string, $allContext, $distance as xs:integer)
{
    let $distanceDecrement := $distance - 1
    let $previousCheck := distinct-values(custom:getListAuthorDistance($author, $allContext, $distanceDecrement, $author))
    for $coAuteur in distinct-values(custom:getListAuthorDistance($author, $allContext, $distance, $author))
    where not($coAuteur = $author) and not($coAuteur = $previousCheck)
        return <distance author1="{$author}" author2="{$coAuteur}" distance="{$distance}" />
};


declare function custom:loopDistance($author as xs:string, $allContext)
{
    for $i at $index in distinct-values($allContext//author)
    return custom:prepareDistanceAuthor($author, $allContext, $index)
};

<distances>
{
    for $author in distinct-values(//author)
        return custom:loopDistance($author, //*)
}
</distances>