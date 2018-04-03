for $proceeding in //proceedings
    return <proceedings>
                <proc_title>{data($proceeding/title)}</proc_title>
                {
                    for $inproceeding in //inproceedings[crossref=data($proceeding/@key)]
                    return <title>{data($inproceeding/title)}</title>
                }
            </proceedings>
            

