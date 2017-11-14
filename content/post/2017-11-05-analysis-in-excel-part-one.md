---
title: Analysis in Excel - Part One
author: ~
date: '2017-11-05'
slug: analysis-in-excel-part-one
categories: [Excel]
tags: [Excel, Analytics]
thumbnailImage: "/img/accountant-1794122_640.png"
thumbnailImagePosition: left
---

[Last week](https://jbraggins.netlify.com/2017/10/in-defence-of-excel) I promised to post the first of two parts on using Excel for analysis. With the first post, I thought I'd list some useful functions in Excel, and provide some examples on how to use them. Please note that this list isn't comprehensive - there are numerous other functions that can and should be learned to complement what is included here.

### Look-up functions

Look-up functions are used when you want to find a value that relates to another.

#### VLOOKUP

VLOOKUP (vertical lookup) is a function that looks for a value in the first column, and then returns a value in the same row from a specified column. Here's the syntax:

  ```
  = VLOOKUP(lookup value, table to retrieve value from, column from table to retrieve value from, TRUE for approximate match/FALSE for exact match) 
  ```
Example:

<img src="/img/vlookup.png" title="Vlookup example"/>

One drawback of using the VLOOKUP function is that it can only look from left-to-right. If you want to look for a value from right-to-left you would use .

#### INDEX + MATCH

INDEX + MATCH is two functions used together. INDEX is used to return a specified value from a defined column/range. MATCH is used to return a number based on the position of a specified value within a defined column/range. When used together you have:

  ```
  = INDEX(Column to return a value from, MATCH(lookup value, Column to lookup against, "0" for an exact match))  
  ```
  
Example:

<img src="/img/index+match.png" title="index + match example"/>

There are many other look-up functions worth looking into like HLOOKUP, or more advanced versions of INDEX + MATCH (e.g. INDEX + MATCH + MATCH), but I personally believe that VLOOKUP and INDEX + MATCH are the best look-up functions to learn first. 

### Conditional and Logical functions

Conditional functions are used to test whether a value meets a condition or not. Whereas logical functions are used to test multiple conditions instead of just one. Logical functions will return either TRUE or FALSE depending on the outcome of the test.   

#### IF

IF is used to test a condition and return a value if the condition is met, or another value if the condition isn't met. 

  ```
  = IF(test, value if the condition is met, value if the condition isn't met)  
  ```
  
Example:

<img src="/img/if.png" title="if example"/>

#### AND 

AND will return TRUE if all arguments are TRUE.

  ```
  = AND(first equals second value, third value equals fourth value)  
  ```

Example:

<img src="/img/and.png" title="and example"/>

#### OR

OR will return TRUE if any of the arguments are TRUE.

  ```
  = OR(first equals second value, third value equals fourth value)  
  ```

Example:

<img src="/img/or.png" title="orr example"/>


AND and OR can be nested in the IF function when you need several test conditions. For example:
  
  ```
  = IF(AND(first value equals second value, third value equals fourth value), value if true, value if false)  
  ```

The syntax is the same for using OR in place of AND when nested in IF. 
There are other conditional and logical functions worth learning like IFERROR, IFNA and NOT. If you are new to these types of functions then IF, AND and OR are a good place to start. 

### Text functions

Text functions are useful for cleaning or converting the case of a text string.

#### TRIM

TRIM is used to remove spaces at the start or end of a text string, or to remove duplicate spaces. The syntax is simple: 
  
  ```
  = TRIM(text to remove extra spaces from)  
  ```

#### CLEAN

CLEAN is used to remove non-printable characters from a cell. These non-printable characters usually appear at the start of data that was imported into Excel from another application.

  ```
	= CLEAN(text to remove non-printable characters from)  
  ```

#### LOWER, UPPER and PROPER

LOWER, UPPER and PROPER are used change the case of a text string. All three functions have similar syntax to TRIM and CLEAN, i.e:

  ```
  = LOWER(text to change to lower case)/UPPER(text to change to upper case)/PROPER(text to sentence case)  
  ```

### Other functions

#### CONCATENATE

CONCATENATE is used to combine a series of provided text strings into one text string. This can be useful when you need to create a unique ID for a row by using the provided text strings (I've often used this when I need to find duplicated rows in a dataset). 

  ```
  = CONCATENATE(text1, text2, . )  
  ```
  
Example:

<img src="/img/concatenate.png" title="concatenate example"/>

#### LEN

LEN is used to find the length of a text string in a cell. 

  ```
  = LEN(text to check length of)  
  ```
  
Example:

<img src="/img/len.png" title="len example"/>

### Conclusion

That's it for now. For my second post on using Excel for analysis I'll explore other useful analytical tools like pivot tables, charts and conditional formatting.

Excel is more-often-than-not the default application provided by organisations for data analysis, therefore it is always useful to keep your skills up-to-date. Even if you have other tools at your disposal, it's always worth starting with Excel to build intuition and knowledge before attempting more advanced applications like R or Python. 

##### Is there anything that I've missed? Or, would you like to know about another function not included here? Let me know below. Thanks, and make sure to check-in next week for part two of Analysis in Excel! 
