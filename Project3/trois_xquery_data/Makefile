all: query1 query2

query1:
	java -cp "saxon9he.jar" net.sf.saxon.Query -s:dblp-excerpt.xml -q:request1.xquery -o:output1.xml

test1:
	java -cp "saxon9he.jar" net.sf.saxon.Query -s:litle_dblp-excerpt.xml -q:request1.xquery -o:test_output1.xml

query2:
	java -cp "saxon9he.jar" net.sf.saxon.Query -s:dblp-excerpt.xml -q:request2.xquery -o:output2.xml

test2:
	java -cp "saxon9he.jar" net.sf.saxon.Query -s:litle_dblp-excerpt.xml -q:request2.xquery -o:test_output2.xml

query3:
	java -cp "saxon9he.jar" net.sf.saxon.Query -s:dblp-excerpt.xml -q:request3.xquery -o:output3.xml

test3:
	java -cp "saxon9he.jar" net.sf.saxon.Query -s:litle_dblp-excerpt.xml -q:request3.xquery -o:test_output3.xml
