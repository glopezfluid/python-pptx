.. _cht-categories:

Chart - Categories
==================

Caveats
-------

* Categories are read from the first series in the plot. In all normal
  situations I've ever encountered, all series have exactly the same set of
  categories.
  
  I'm not sure why the category labels are redundantly applied to each series,
  but the fact that they are leads me to believe I must be missing something;
  I don't believe they would repeat them like that if there wasn't a situation
  in which they could be different between two series in the same plot.

  Consequently, there might be some edge cases where this won't work quite as
  expected. At the same time, I expect it will work exactly as expected for
  99.9% of the cases, maybe 99.99%.


Multilevel Categories
---------------------

A category chart can have more than one level of categories, where each
individual category is nested in a higher-level category.

https://www.youtube.com/watch?v=KbyQpzA7fLo


Acceptance Tests
----------------

.. highlight:: cucumber

cht-plot-props.feature::

  Scenario: Get CategoryPlot.categories
    Given a category plot
     Then plot.categories is a Categories object

cht-categories.feature::

  Scenario: Categories.__len__()
    Given a Categories object having 3 categories
     Then len(categories) is 3

  Scenario: Categories.__getitem__()
    Given a Categories object having 3 categories
     Then categories[2] is a Category object

  Scenario: Categories.__iter__()
    Given a Categories object having 3 categories
     Then iterating categories produces 3 Category objects

  Scenario: Categories.depth
    Given a Categories object having 3 levels of categories
     Then categories.depth is 3

  Scenario: Categories.flattened
    Given a Categories object having 3 levels of categories
     Then categories.flattened is tuple of 3-tuples

cht-category.feature::

  Scenario: Category derives from string
    Given a Category object
     Then isinstance(category, str) is True


XML semantics
-------------

* The hierarchy of the levels is indicated by their document order.

* The scope of non-leaf category entries is indicated by the 'idx' attribute
  value. A non-leaf category spans from the leaf node having the matching idx
  to the last leaf node not contained in its subsequent sibling.

Q. What behavior is produced by a truthy value in
   `c:catAx/c:noMultiLvlLbl/@val` when there are multiple levels of categories
   defined?



XML specimens
-------------

.. highlight:: xml

::

  <c:cat>
     <c:multiLvlStrRef>
       <c:f>Sheet1!$C$1:$J$3</c:f>
       <c:multiLvlStrCache>
         <c:ptCount val="8"/>
         <c:lvl>
           <c:pt idx="0">
             <c:v>county one</c:v>
           </c:pt>
           <c:pt idx="1">
             <c:v>county two</c:v>
           </c:pt>
           <c:pt idx="2">
             <c:v>county one</c:v>
           </c:pt>
           <c:pt idx="3">
             <c:v>county two</c:v>
           </c:pt>
           <c:pt idx="4">
             <c:v>county one</c:v>
           </c:pt>
           <c:pt idx="5">
             <c:v>county two</c:v>
           </c:pt>
           <c:pt idx="6">
             <c:v>country one</c:v>
           </c:pt>
           <c:pt idx="7">
             <c:v>county two</c:v>
           </c:pt>
         </c:lvl>
         <c:lvl>
           <c:pt idx="0">
             <c:v>city one</c:v>
           </c:pt>
           <c:pt idx="2">
             <c:v>city two </c:v>
           </c:pt>
           <c:pt idx="4">
             <c:v>city one</c:v>
           </c:pt>
           <c:pt idx="6">
             <c:v>city two </c:v>
           </c:pt>
         </c:lvl>
         <c:lvl>
           <c:pt idx="0">
             <c:v>UK</c:v>
           </c:pt>
           <c:pt idx="4">
             <c:v>US</c:v>
           </c:pt>
         </c:lvl>
       </c:multiLvlStrCache>
     </c:multiLvlStrRef>
   </c:cat>


  <c:catAx>
    ...
    <c:noMultiLvlLbl val="0"/>
  </c:catAx>


Related Schema Definitions
--------------------------

.. highlight:: xml

A ``<c:cat>`` element is of the ``CT_AxDataSource`` type::

  <xsd:complexType name="CT_AxDataSource">
    <xsd:sequence>
      <xsd:choice minOccurs="1" maxOccurs="1">
        <xsd:element name="multiLvlStrRef" type="CT_MultiLvlStrRef"/>
        <xsd:element name="numRef"         type="CT_NumRef"/>
        <xsd:element name="numLit"         type="CT_NumData"/>
        <xsd:element name="strRef"         type="CT_StrRef"/>
        <xsd:element name="strLit"         type="CT_StrData"/>
      </xsd:choice>
    </xsd:sequence>
  </xsd:complexType>

  <xsd:complexType name="CT_MultiLvlStrRef">
    <xsd:sequence>
      <xsd:element name="f"                type="xsd:string"/>
      <xsd:element name="multiLvlStrCache" type="CT_MultiLvlStrData" minOccurs="0"/>
      <xsd:element name="extLst"           type="CT_ExtensionList"   minOccurs="0"/>
    </xsd:sequence>
  </xsd:complexType>

  <xsd:complexType name="CT_MultiLvlStrData">
    <xsd:sequence>
      <xsd:element name="ptCount" type="CT_UnsignedInt"   minOccurs="0"/>
      <xsd:element name="lvl"     type="CT_Lvl"           minOccurs="0" maxOccurs="unbounded"/>
      <xsd:element name="extLst"  type="CT_ExtensionList" minOccurs="0"/>
    </xsd:sequence>
  </xsd:complexType>
