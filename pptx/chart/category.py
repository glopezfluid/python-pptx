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

from collections import Sequence


class Categories(Sequence):
    """
    A sequence of |Category| objects, each representing a category label on
    the chart. Provides properties for dealing with hierarchical categories.
    """
    def __init__(self, xChart):
        super(Categories, self).__init__()
        self._xChart = xChart

    def __getitem__(self, idx):
        pt = self._xChart.cat_pts[idx]
        return Category(pt)

    def __len__(self):
        return len(self._xChart.cat_pts)

    @property
    def depth(self):
        """
        Return an integer representing the number of hierarchical levels in
        this collection. Returns 1 for non-hierarchical categories and 0 if
        no categories are present (generally meaning no series are present).
        """
        cat = self._cat
        if cat is None:
            return 0
        if cat.multiLvlStrRef is None:
            return 1
        return len(cat.lvls)

    @property
    def _cat(self):
        """
        Return the `c:cat` element of the first series in xChart or |None| if
        not present.
        """
        sers = self._xChart.sers
        if not sers:
            return None
        return sers[0].cat


class Category(str):
    """
    A sequence of |Category| objects, each representing a category label on
    the chart. Provides properties for dealing with hierarchical categories.
    """
    def __new__(cls, pt, *args):
        category_label = pt.v.text
        return str.__new__(cls, category_label)

    def __init__(self, pt):
        self._element = self._pt = pt
