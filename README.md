## Sales Engine
### Some Notes.

last time we had bad testing and bad coverage. we were forced to write vague test
because it was difficult to produce and verify fixture data

the solution was to put our mock engine into a function that accepts custom data each time
so if we need it to be its clear in each test or file what data we are testing against.

another problem I ran up against is that the fixture data wasn't complete enough to test the connections between the different parts of the program.

the issue is that you can tweak an individual part of the fixture so that you have something for your test to grab onto but that tweaking adds up and you end up breaking other test when you keep changing the fixture data.

the solution to this is to change the order in which you approach the testing. focus on getting test to fail instead of error. make sure test are all failing because the methods they are testing are returning a different value than what is expected then you can edit the fixture all at once to so you can make sure your code is being tested

so we have several different methods of isolating data
* custom data fed into a method that spits out an simplfied engine that you can test against
* changing the data only AFTER you are sure your test are looking into the data correctly

* isolating which parts of the data you are testing

* multiple fixture folders for each category of test.