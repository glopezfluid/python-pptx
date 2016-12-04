# encoding: utf-8

"""
Category-related objects. The |Categories| object is returned by
``Plot.categories`` and contains zero or more |Category| objects, each
representing one of the category labels associated with the plot. Categories
can be hierarchical, so there are members allowing discovery of the depth of
that hierarchy and means to navigate it.
"""

from __future__ import (
    absolute_import, division, print_function, unicode_literals
)


class Categories(object):
    """
    A sequence of |Category| objects, each representing a category label on
    the chart. Provides properties for dealing with hierarchical categories.
    """
    def __init__(self, xChart):
        super(Categories, self).__init__()
        self._xChart = xChart
