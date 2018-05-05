declare namespace custom = "http://example.com";


declare function custom:distanceAuthor($author as xs:string, $allContext, $initDistance as xs:integer, $distance as xs:integer, $coAuteur as xs:string, $alreadyCheck)
{
    if($distance > 0) then (
        let $newDistance := $distance - 1
        for $newCoAuteur in distinct-values($allContext[author=$coAuteur]/author)
        where not($newCoAuteur = $author) and not($coAuteur = $newCoAuteur)
            return custom:distanceAuthor($author, $allContext, $initDistance, $newDistance, $newCoAuteur, $alreadyCheck)
    )
    else (
        if(not($coAuteur = $alreadyCheck)) then (
            <distance author1="{$author}" author2="{$coAuteur}" distance="{$initDistance}" alreadyCheck="{$alreadyCheck}" />
        ) else ()
    )
};

declare function custom:getPreviousAuthorCheck($author as xs:string, $allContext, $distance as xs:integer, $coAuteur as xs:string)
{
    if($distance > 0) then (
        let $newDistance := $distance - 1
        for $newCoAuteur in distinct-values($allContext[author=$coAuteur]/author)
        where not($newCoAuteur = $author) and not($coAuteur = $newCoAuteur)
            return ($newCoAuteur, custom:getPreviousAuthorCheck($author, $allContext, $newDistance, $newCoAuteur))
    )
    else (
        $coAuteur
    )
};

declare function custom:prepareDistanceAuthor($author as xs:string, $allContext, $distance as xs:integer)
{
    let $distanceDecrement := $distance - 1
    let $previousCheck := distinct-values(custom:getPreviousAuthorCheck($author, $allContext, $distanceDecrement, $author))
    return custom:distanceAuthor($author, $allContext, $distance, $distance, $author, $previousCheck)
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