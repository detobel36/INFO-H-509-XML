all: query1 query2

query2:
	java -cp "saxon9he.jar" net.sf.saxon.Query -s:dblp-excerpt.xml -q:request2.xquery -o:output2.xml

test2:
	java -cp "saxon9he.jar" net.sf.saxon.Query -s:litle_dblp-excerpt.xml -q:request2.xquery -o:test_output2.xml

query1:
	java -cp "saxon9he.jar" net.sf.saxon.Query -s:dblp-excerpt.xml -q:request1.xquery -o:output1.xml

test1:
	java -cp "saxon9he.jar" net.sf.saxon.Query -s:litle_dblp-excerpt.xml -q:request1.xquery -o:test_output1.xml