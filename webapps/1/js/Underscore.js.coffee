#     Underscore.js 1.8.3
#     http://underscorejs.org
#     (c) 2009-2015 Jeremy Ashkenas, DocumentCloud and Investigative Reporters & Editors
#     Underscore may be freely distributed under the MIT license.
(->
  # Baseline setup
  # --------------
  # Establish the root object, `window` in the browser, or `exports` on the server.
  root = this
  # Save the previous value of the `_` variable.
  previousUnderscore = root._
  # Save bytes in the minified (but not gzipped) version:
  ArrayProto = Array.prototype
  ObjProto = Object.prototype
  FuncProto = Function.prototype
  # Create quick reference variables for speed access to core prototypes.
  push = ArrayProto.push
  slice = ArrayProto.slice
  toString = ObjProto.toString
  hasOwnProperty = ObjProto.hasOwnProperty
  # All **ECMAScript 5** native function implementations that we hope to use
  # are declared here.
  nativeIsArray = Array.isArray
  nativeKeys = Object.keys
  nativeBind = FuncProto.bind
  nativeCreate = Object.create
  # Naked function reference for surrogate-prototype-swapping.

  Ctor = ->

  # Create a safe reference to the Underscore object for use below.

  _ = (obj) ->
    if obj instanceof _
      return obj
    if !(this instanceof _)
      return new _(obj)
    @_wrapped = obj
    return

  # Export the Underscore object for **Node.js**, with
  # backwards-compatibility for the old `require()` API. If we're in
  # the browser, add `_` as a global object.
  # Create a reducing function iterating left or right.

  createReduce = (dir) ->
    # Optimized iterator function as using arguments.length
    # in the main function will deoptimize the, see #1991.

    iterator = (obj, iteratee, memo, keys, index, length) ->
      while index >= 0 and index < length
        currentKey = if keys then keys[index] else index
        memo = iteratee(memo, obj[currentKey], currentKey, obj)
        index += dir
      memo

    (obj, iteratee, memo, context) ->
      iteratee = optimizeCb(iteratee, context, 4)
      keys = !isArrayLike(obj) and _.keys(obj)
      length = (keys or obj).length
      index = if dir > 0 then 0 else length - 1
      # Determine the initial value if none is provided.
      if arguments.length < 3
        memo = obj[if keys then keys[index] else index]
        index += dir
      iterator obj, iteratee, memo, keys, index, length

  # Generator function to create the findIndex and findLastIndex functions

  createPredicateIndexFinder = (dir) ->
    (array, predicate, context) ->
      predicate = cb(predicate, context)
      length = getLength(array)
      index = if dir > 0 then 0 else length - 1
      while index >= 0 and index < length
        if predicate(array[index], index, array)
          return index
        index += dir
      -1

  # Generator function to create the indexOf and lastIndexOf functions

  createIndexFinder = (dir, predicateFind, sortedIndex) ->
    (array, item, idx) ->
      i = 0
      length = getLength(array)
      if typeof idx == 'number'
        if dir > 0
          i = if idx >= 0 then idx else Math.max(idx + length, i)
        else
          length = if idx >= 0 then Math.min(idx + 1, length) else idx + length + 1
      else if sortedIndex and idx and length
        idx = sortedIndex(array, item)
        return if array[idx] == item then idx else -1
      if item != item
        idx = predicateFind(slice.call(array, i, length), _.isNaN)
        return if idx >= 0 then idx + i else -1
      idx = if dir > 0 then i else length - 1
      while idx >= 0 and idx < length
        if array[idx] == item
          return idx
        idx += dir
      -1

  collectNonEnumProps = (obj, keys) ->
    nonEnumIdx = nonEnumerableProps.length
    constructor = obj.constructor
    proto = _.isFunction(constructor) and constructor.prototype or ObjProto
    # Constructor is a special case.
    prop = 'constructor'
    if _.has(obj, prop) and !_.contains(keys, prop)
      keys.push prop
    while nonEnumIdx--
      prop = nonEnumerableProps[nonEnumIdx]
      if prop of obj and obj[prop] != proto[prop] and !_.contains(keys, prop)
        keys.push prop
    return

  if typeof exports != 'undefined'
    if typeof module != 'undefined' and module.exports
      exports = module.exports = _
    exports._ = _
  else
    root._ = _
  # Current version.
  _.VERSION = '1.8.3'
  # Internal function that returns an efficient (for current engines) version
  # of the passed-in callback, to be repeatedly applied in other Underscore
  # functions.

  optimizeCb = (func, context, argCount) ->
    if context == undefined
      return func
    switch (if argCount == null then 3 else argCount)
      when 1
        return (value) ->
          func.call context, value

      when 2
        return (value, other) ->
          func.call context, value, other

      when 3
        return (value, index, collection) ->
          func.call context, value, index, collection

      when 4
        return (accumulator, value, index, collection) ->
          func.call context, accumulator, value, index, collection

    ->
      func.apply context, arguments

  # A mostly-internal function to generate callbacks that can be applied
  # to each element in a collection, returning the desired result — either
  # identity, an arbitrary callback, a property matcher, or a property accessor.

  cb = (value, context, argCount) ->
    if value == null
      return _.identity
    if _.isFunction(value)
      return optimizeCb(value, context, argCount)
    if _.isObject(value)
      return _.matcher(value)
    _.property value

  _.iteratee = (value, context) ->
    cb value, context, Infinity

  # An internal function for creating assigner functions.

  createAssigner = (keysFunc, undefinedOnly) ->
    (obj) ->
      length = arguments.length
      if length < 2 or obj == null
        return obj
      index = 1
      while index < length
        source = arguments[index]
        keys = keysFunc(source)
        l = keys.length
        i = 0
        while i < l
          key = keys[i]
          if !undefinedOnly or obj[key] == undefined
            obj[key] = source[key]
          i++
        index++
      obj

  # An internal function for creating a new object that inherits from another.

  baseCreate = (prototype) ->
    if !_.isObject(prototype)
      return {}
    if nativeCreate
      return nativeCreate(prototype)
    Ctor.prototype = prototype
    result = new Ctor
    Ctor.prototype = null
    result

  property = (key) ->
    (obj) ->
      if obj == null then undefined else obj[key]

  # Helper for collection methods to determine whether a collection
  # should be iterated as an array or as an object
  # Related: http://people.mozilla.org/~jorendorff/es6-draft.html#sec-tolength
  # Avoids a very nasty iOS 8 JIT bug on ARM-64. #2094
  MAX_ARRAY_INDEX = 2 ** 53 - 1
  getLength = property('length')

  isArrayLike = (collection) ->
    length = getLength(collection)
    typeof length == 'number' and length >= 0 and length <= MAX_ARRAY_INDEX

  # Collection Functions
  # --------------------
  # The cornerstone, an `each` implementation, aka `forEach`.
  # Handles raw objects in addition to array-likes. Treats all
  # sparse array-likes as if they were dense.
  _.each =
  _.forEach = (obj, iteratee, context) ->
    iteratee = optimizeCb(iteratee, context)
    i = undefined
    length = undefined
    if isArrayLike(obj)
      i = 0
      length = obj.length
      while i < length
        iteratee obj[i], i, obj
        i++
    else
      keys = _.keys(obj)
      i = 0
      length = keys.length
      while i < length
        iteratee obj[keys[i]], keys[i], obj
        i++
    obj

  # Return the results of applying the iteratee to each element.
  _.map =
  _.collect = (obj, iteratee, context) ->
    iteratee = cb(iteratee, context)
    keys = !isArrayLike(obj) and _.keys(obj)
    length = (keys or obj).length
    results = Array(length)
    index = 0
    while index < length
      currentKey = if keys then keys[index] else index
      results[index] = iteratee(obj[currentKey], currentKey, obj)
      index++
    results

  # **Reduce** builds up a single result from a list of values, aka `inject`,
  # or `foldl`.
  _.reduce = _.foldl = _.inject = createReduce(1)
  # The right-associative version of reduce, also known as `foldr`.
  _.reduceRight = _.foldr = createReduce(-1)
  # Return the first value which passes a truth test. Aliased as `detect`.
  _.find =
  _.detect = (obj, predicate, context) ->
    key = undefined
    if isArrayLike(obj)
      key = _.findIndex(obj, predicate, context)
    else
      key = _.findKey(obj, predicate, context)
    if key != undefined and key != -1
      return obj[key]
    return

  # Return all the elements that pass a truth test.
  # Aliased as `select`.
  _.filter =
  _.select = (obj, predicate, context) ->
    results = []
    predicate = cb(predicate, context)
    _.each obj, (value, index, list) ->
      if predicate(value, index, list)
        results.push value
      return
    results

  # Return all the elements for which a truth test fails.

  _.reject = (obj, predicate, context) ->
    _.filter obj, _.negate(cb(predicate)), context

  # Determine whether all of the elements match a truth test.
  # Aliased as `all`.
  _.every =
  _.all = (obj, predicate, context) ->
    predicate = cb(predicate, context)
    keys = !isArrayLike(obj) and _.keys(obj)
    length = (keys or obj).length
    index = 0
    while index < length
      currentKey = if keys then keys[index] else index
      if !predicate(obj[currentKey], currentKey, obj)
        return false
      index++
    true

  # Determine if at least one element in the object matches a truth test.
  # Aliased as `any`.
  _.some =
  _.any = (obj, predicate, context) ->
    predicate = cb(predicate, context)
    keys = !isArrayLike(obj) and _.keys(obj)
    length = (keys or obj).length
    index = 0
    while index < length
      currentKey = if keys then keys[index] else index
      if predicate(obj[currentKey], currentKey, obj)
        return true
      index++
    false

  # Determine if the array or object contains a given item (using `===`).
  # Aliased as `includes` and `include`.
  _.contains = _.includes =
  _.include = (obj, item, fromIndex, guard) ->
    if !isArrayLike(obj)
      obj = _.values(obj)
    if typeof fromIndex != 'number' or guard
      fromIndex = 0
    _.indexOf(obj, item, fromIndex) >= 0

  # Invoke a method (with arguments) on every item in a collection.

  _.invoke = (obj, method) ->
    args = slice.call(arguments, 2)
    isFunc = _.isFunction(method)
    _.map obj, (value) ->
      func = if isFunc then method else value[method]
      if func == null then func else func.apply(value, args)

  # Convenience version of a common use case of `map`: fetching a property.

  _.pluck = (obj, key) ->
    _.map obj, _.property(key)

  # Convenience version of a common use case of `filter`: selecting only objects
  # containing specific `key:value` pairs.

  _.where = (obj, attrs) ->
    _.filter obj, _.matcher(attrs)

  # Convenience version of a common use case of `find`: getting the first object
  # containing specific `key:value` pairs.

  _.findWhere = (obj, attrs) ->
    _.find obj, _.matcher(attrs)

  # Return the maximum element (or element-based computation).

  _.max = (obj, iteratee, context) ->
    result = -Infinity
    lastComputed = -Infinity
    value = undefined
    computed = undefined
    if iteratee == null and obj != null
      obj = if isArrayLike(obj) then obj else _.values(obj)
      i = 0
      length = obj.length
      while i < length
        value = obj[i]
        if value > result
          result = value
        i++
    else
      iteratee = cb(iteratee, context)
      _.each obj, (value, index, list) ->
        computed = iteratee(value, index, list)
        if computed > lastComputed or computed == -Infinity and result == -Infinity
          result = value
          lastComputed = computed
        return
    result

  # Return the minimum element (or element-based computation).

  _.min = (obj, iteratee, context) ->
    result = Infinity
    lastComputed = Infinity
    value = undefined
    computed = undefined
    if iteratee == null and obj != null
      obj = if isArrayLike(obj) then obj else _.values(obj)
      i = 0
      length = obj.length
      while i < length
        value = obj[i]
        if value < result
          result = value
        i++
    else
      iteratee = cb(iteratee, context)
      _.each obj, (value, index, list) ->
        computed = iteratee(value, index, list)
        if computed < lastComputed or computed == Infinity and result == Infinity
          result = value
          lastComputed = computed
        return
    result

  # Shuffle a collection, using the modern version of the
  # [Fisher-Yates shuffle](http://en.wikipedia.org/wiki/Fisher–Yates_shuffle).

  _.shuffle = (obj) ->
    set = if isArrayLike(obj) then obj else _.values(obj)
    length = set.length
    shuffled = Array(length)
    index = 0
    rand = undefined
    while index < length
      rand = _.random(0, index)
      if rand != index
        shuffled[index] = shuffled[rand]
      shuffled[rand] = set[index]
      index++
    shuffled

  # Sample **n** random values from a collection.
  # If **n** is not specified, returns a single random element.
  # The internal `guard` argument allows it to work with `map`.

  _.sample = (obj, n, guard) ->
    if n == null or guard
      if !isArrayLike(obj)
        obj = _.values(obj)
      return obj[_.random(obj.length - 1)]
    _.shuffle(obj).slice 0, Math.max(0, n)

  # Sort the object's values by a criterion produced by an iteratee.

  _.sortBy = (obj, iteratee, context) ->
    iteratee = cb(iteratee, context)
    _.pluck _.map(obj, (value, index, list) ->
      {
        value: value
        index: index
        criteria: iteratee(value, index, list)
      }
    ).sort((left, right) ->
      a = left.criteria
      b = right.criteria
      if a != b
        if a > b or a == undefined
          return 1
        if a < b or b == undefined
          return -1
      left.index - (right.index)
    ), 'value'

  # An internal function used for aggregate "group by" operations.

  group = (behavior) ->
    (obj, iteratee, context) ->
      result = {}
      iteratee = cb(iteratee, context)
      _.each obj, (value, index) ->
        key = iteratee(value, index, obj)
        behavior result, value, key
        return
      result

  # Groups the object's values by a criterion. Pass either a string attribute
  # to group by, or a function that returns the criterion.
  _.groupBy = group((result, value, key) ->
    if _.has(result, key)
      result[key].push value
    else
      result[key] = [ value ]
    return
  )
  # Indexes the object's values by a criterion, similar to `groupBy`, but for
  # when you know that your index values will be unique.
  _.indexBy = group((result, value, key) ->
    result[key] = value
    return
  )
  # Counts instances of an object that group by a certain criterion. Pass
  # either a string attribute to count by, or a function that returns the
  # criterion.
  _.countBy = group((result, value, key) ->
    if _.has(result, key)
      result[key]++
    else
      result[key] = 1
    return
  )
  # Safely create a real, live array from anything iterable.

  _.toArray = (obj) ->
    if !obj
      return []
    if _.isArray(obj)
      return slice.call(obj)
    if isArrayLike(obj)
      return _.map(obj, _.identity)
    _.values obj

  # Return the number of elements in an object.

  _.size = (obj) ->
    if obj == null
      return 0
    if isArrayLike(obj) then obj.length else _.keys(obj).length

  # Split a collection into two arrays: one whose elements all satisfy the given
  # predicate, and one whose elements all do not satisfy the predicate.

  _.partition = (obj, predicate, context) ->
    predicate = cb(predicate, context)
    pass = []
    fail = []
    _.each obj, (value, key, obj) ->
      (if predicate(value, key, obj) then pass else fail).push value
      return
    [
      pass
      fail
    ]

  # Array Functions
  # ---------------
  # Get the first element of an array. Passing **n** will return the first N
  # values in the array. Aliased as `head` and `take`. The **guard** check
  # allows it to work with `_.map`.
  _.first = _.head =
  _.take = (array, n, guard) ->
    if array == null
      return undefined
    if n == null or guard
      return array[0]
    _.initial array, array.length - n

  # Returns everything but the last entry of the array. Especially useful on
  # the arguments object. Passing **n** will return all the values in
  # the array, excluding the last N.

  _.initial = (array, n, guard) ->
    slice.call array, 0, Math.max(0, array.length - (if n == null or guard then 1 else n))

  # Get the last element of an array. Passing **n** will return the last N
  # values in the array.

  _.last = (array, n, guard) ->
    if array == null
      return undefined
    if n == null or guard
      return array[array.length - 1]
    _.rest array, Math.max(0, array.length - n)

  # Returns everything but the first entry of the array. Aliased as `tail` and `drop`.
  # Especially useful on the arguments object. Passing an **n** will return
  # the rest N values in the array.
  _.rest = _.tail =
  _.drop = (array, n, guard) ->
    slice.call array, if n == null or guard then 1 else n

  # Trim out all falsy values from an array.

  _.compact = (array) ->
    _.filter array, _.identity

  # Internal implementation of a recursive `flatten` function.

  flatten = (input, shallow, strict, startIndex) ->
    output = []
    idx = 0
    i = startIndex or 0
    length = getLength(input)
    while i < length
      value = input[i]
      if isArrayLike(value) and (_.isArray(value) or _.isArguments(value))
        #flatten current level of array or arguments object
        if !shallow
          value = flatten(value, shallow, strict)
        j = 0
        len = value.length
        output.length += len
        while j < len
          output[idx++] = value[j++]
      else if !strict
        output[idx++] = value
      i++
    output

  # Flatten out an array, either recursively (by default), or just one level.

  _.flatten = (array, shallow) ->
    flatten array, shallow, false

  # Return a version of the array that does not contain the specified value(s).

  _.without = (array) ->
    _.difference array, slice.call(arguments, 1)

  # Produce a duplicate-free version of the array. If the array has already
  # been sorted, you have the option of using a faster algorithm.
  # Aliased as `unique`.
  _.uniq =
  _.unique = (array, isSorted, iteratee, context) ->
    if !_.isBoolean(isSorted)
      context = iteratee
      iteratee = isSorted
      isSorted = false
    if iteratee != null
      iteratee = cb(iteratee, context)
    result = []
    seen = []
    i = 0
    length = getLength(array)
    while i < length
      value = array[i]
      computed = if iteratee then iteratee(value, i, array) else value
      if isSorted
        if !i or seen != computed
          result.push value
        seen = computed
      else if iteratee
        if !_.contains(seen, computed)
          seen.push computed
          result.push value
      else if !_.contains(result, value)
        result.push value
      i++
    result

  # Produce an array that contains the union: each distinct element from all of
  # the passed-in arrays.

  _.union = ->
    _.uniq flatten(arguments, true, true)

  # Produce an array that contains every item shared between all the
  # passed-in arrays.

  _.intersection = (array) ->
    result = []
    argsLength = arguments.length
    i = 0
    length = getLength(array)
    while i < length
      item = array[i]
      if _.contains(result, item)
        i++
        continue
      j = 1
      while j < argsLength
        if !_.contains(arguments[j], item)
          break
        j++
      if j == argsLength
        result.push item
      i++
    result

  # Take the difference between one array and a number of other arrays.
  # Only the elements present in just the first array will remain.

  _.difference = (array) ->
    rest = flatten(arguments, true, true, 1)
    _.filter array, (value) ->
      !_.contains(rest, value)

  # Zip together multiple lists into a single array -- elements that share
  # an index go together.

  _.zip = ->
    _.unzip arguments

  # Complement of _.zip. Unzip accepts an array of arrays and groups
  # each array's elements on shared indices

  _.unzip = (array) ->
    length = array and _.max(array, getLength).length or 0
    result = Array(length)
    index = 0
    while index < length
      result[index] = _.pluck(array, index)
      index++
    result

  # Converts lists into objects. Pass either a single array of `[key, value]`
  # pairs, or two parallel arrays of the same length -- one of keys, and one of
  # the corresponding values.

  _.object = (list, values) ->
    result = {}
    i = 0
    length = getLength(list)
    while i < length
      if values
        result[list[i]] = values[i]
      else
        result[list[i][0]] = list[i][1]
      i++
    result

  # Returns the first index on an array-like that passes a predicate test
  _.findIndex = createPredicateIndexFinder(1)
  _.findLastIndex = createPredicateIndexFinder(-1)
  # Use a comparator function to figure out the smallest index at which
  # an object should be inserted so as to maintain order. Uses binary search.

  _.sortedIndex = (array, obj, iteratee, context) ->
    iteratee = cb(iteratee, context, 1)
    value = iteratee(obj)
    low = 0
    high = getLength(array)
    while low < high
      mid = Math.floor((low + high) / 2)
      if iteratee(array[mid]) < value
        low = mid + 1
      else
        high = mid
    low

  # Return the position of the first occurrence of an item in an array,
  # or -1 if the item is not included in the array.
  # If the array is large and already in sort order, pass `true`
  # for **isSorted** to use binary search.
  _.indexOf = createIndexFinder(1, _.findIndex, _.sortedIndex)
  _.lastIndexOf = createIndexFinder(-1, _.findLastIndex)
  # Generate an integer Array containing an arithmetic progression. A port of
  # the native Python `range()` function. See
  # [the Python documentation](http://docs.python.org/library/functions.html#range).

  _.range = (start, stop, step) ->
    if stop == null
      stop = start or 0
      start = 0
    step = step or 1
    length = Math.max(Math.ceil((stop - start) / step), 0)
    range = Array(length)
    idx = 0
    while idx < length
      range[idx] = start
      idx++
      start += step
    range

  # Function (ahem) Functions
  # ------------------
  # Determines whether to execute a function as a constructor
  # or a normal function with the provided arguments

  executeBound = (sourceFunc, boundFunc, context, callingContext, args) ->
    if !(callingContext instanceof boundFunc)
      return sourceFunc.apply(context, args)
    self = baseCreate(sourceFunc.prototype)
    result = sourceFunc.apply(self, args)
    if _.isObject(result)
      return result
    self

  # Create a function bound to a given object (assigning `this`, and arguments,
  # optionally). Delegates to **ECMAScript 5**'s native `Function.bind` if
  # available.

  _.bind = (func, context) ->
    if nativeBind and func.bind == nativeBind
      return nativeBind.apply(func, slice.call(arguments, 1))
    if !_.isFunction(func)
      throw new TypeError('Bind must be called on a function')
    args = slice.call(arguments, 2)

    bound = ->
      executeBound func, bound, context, this, args.concat(slice.call(arguments))

    bound

  # Partially apply a function by creating a version that has had some of its
  # arguments pre-filled, without changing its dynamic `this` context. _ acts
  # as a placeholder, allowing any combination of arguments to be pre-filled.

  _.partial = (func) ->
    boundArgs = slice.call(arguments, 1)

    bound = ->
      position = 0
      length = boundArgs.length
      args = Array(length)
      i = 0
      while i < length
        args[i] = if boundArgs[i] == _ then arguments[position++] else boundArgs[i]
        i++
      while position < arguments.length
        args.push arguments[position++]
      executeBound func, bound, this, this, args

    bound

  # Bind a number of an object's methods to that object. Remaining arguments
  # are the method names to be bound. Useful for ensuring that all callbacks
  # defined on an object belong to it.

  _.bindAll = (obj) ->
    i = undefined
    length = arguments.length
    key = undefined
    if length <= 1
      throw new Error('bindAll must be passed function names')
    i = 1
    while i < length
      key = arguments[i]
      obj[key] = _.bind(obj[key], obj)
      i++
    obj

  # Memoize an expensive function by storing its results.

  _.memoize = (func, hasher) ->

    memoize = (key) ->
      cache = memoize.cache
      address = '' + (if hasher then hasher.apply(this, arguments) else key)
      if !_.has(cache, address)
        cache[address] = func.apply(this, arguments)
      cache[address]

    memoize.cache = {}
    memoize

  # Delays a function for the given number of milliseconds, and then calls
  # it with the arguments supplied.

  _.delay = (func, wait) ->
    args = slice.call(arguments, 2)
    setTimeout (->
      func.apply null, args
    ), wait

  # Defers a function, scheduling it to run after the current call stack has
  # cleared.
  _.defer = _.partial(_.delay, _, 1)
  # Returns a function, that, when invoked, will only be triggered at most once
  # during a given window of time. Normally, the throttled function will run
  # as much as it can, without ever going more than once per `wait` duration;
  # but if you'd like to disable the execution on the leading edge, pass
  # `{leading: false}`. To disable execution on the trailing edge, ditto.

  _.throttle = (func, wait, options) ->
    context = undefined
    args = undefined
    result = undefined
    timeout = null
    previous = 0
    if !options
      options = {}

    later = ->
      previous = if options.leading == false then 0 else _.now()
      timeout = null
      result = func.apply(context, args)
      if !timeout
        context = args = null
      return

    ->
      now = _.now()
      if !previous and options.leading == false
        previous = now
      remaining = wait - (now - previous)
      context = this
      args = arguments
      if remaining <= 0 or remaining > wait
        if timeout
          clearTimeout timeout
          timeout = null
        previous = now
        result = func.apply(context, args)
        if !timeout
          context = args = null
      else if !timeout and options.trailing != false
        timeout = setTimeout(later, remaining)
      result

  # Returns a function, that, as long as it continues to be invoked, will not
  # be triggered. The function will be called after it stops being called for
  # N milliseconds. If `immediate` is passed, trigger the function on the
  # leading edge, instead of the trailing.

  _.debounce = (func, wait, immediate) ->
    timeout = undefined
    args = undefined
    context = undefined
    timestamp = undefined
    result = undefined

    later = ->
      last = _.now() - timestamp
      if last < wait and last >= 0
        timeout = setTimeout(later, wait - last)
      else
        timeout = null
        if !immediate
          result = func.apply(context, args)
          if !timeout
            context = args = null
      return

    ->
      context = this
      args = arguments
      timestamp = _.now()
      callNow = immediate and !timeout
      if !timeout
        timeout = setTimeout(later, wait)
      if callNow
        result = func.apply(context, args)
        context = args = null
      result

  # Returns the first function passed as an argument to the second,
  # allowing you to adjust arguments, run code before and after, and
  # conditionally execute the original function.

  _.wrap = (func, wrapper) ->
    _.partial wrapper, func

  # Returns a negated version of the passed-in predicate.

  _.negate = (predicate) ->
    ->
      !predicate.apply(this, arguments)

  # Returns a function that is the composition of a list of functions, each
  # consuming the return value of the function that follows.

  _.compose = ->
    args = arguments
    start = args.length - 1
    ->
      i = start
      result = args[start].apply(this, arguments)
      while i--
        result = args[i].call(this, result)
      result

  # Returns a function that will only be executed on and after the Nth call.

  _.after = (times, func) ->
    ->
      if --times < 1
        return func.apply(this, arguments)
      return

  # Returns a function that will only be executed up to (but not including) the Nth call.

  _.before = (times, func) ->
    memo = undefined
    ->
      if --times > 0
        memo = func.apply(this, arguments)
      if times <= 1
        func = null
      memo

  # Returns a function that will be executed at most one time, no matter how
  # often you call it. Useful for lazy initialization.
  _.once = _.partial(_.before, 2)
  # Object Functions
  # ----------------
  # Keys in IE < 9 that won't be iterated by `for key in ...` and thus missed.
  hasEnumBug = !{ toString: null }.propertyIsEnumerable('toString')
  nonEnumerableProps = [
    'valueOf'
    'isPrototypeOf'
    'toString'
    'propertyIsEnumerable'
    'hasOwnProperty'
    'toLocaleString'
  ]
  # Retrieve the names of an object's own properties.
  # Delegates to **ECMAScript 5**'s native `Object.keys`

  _.keys = (obj) ->
    if !_.isObject(obj)
      return []
    if nativeKeys
      return nativeKeys(obj)
    keys = []
    for key of obj
      if _.has(obj, key)
        keys.push key
    # Ahem, IE < 9.
    if hasEnumBug
      collectNonEnumProps obj, keys
    keys

  # Retrieve all the property names of an object.

  _.allKeys = (obj) ->
    if !_.isObject(obj)
      return []
    keys = []
    for key of obj
      keys.push key
    # Ahem, IE < 9.
    if hasEnumBug
      collectNonEnumProps obj, keys
    keys

  # Retrieve the values of an object's properties.

  _.values = (obj) ->
    keys = _.keys(obj)
    length = keys.length
    values = Array(length)
    i = 0
    while i < length
      values[i] = obj[keys[i]]
      i++
    values

  # Returns the results of applying the iteratee to each element of the object
  # In contrast to _.map it returns an object

  _.mapObject = (obj, iteratee, context) ->
    iteratee = cb(iteratee, context)
    keys = _.keys(obj)
    length = keys.length
    results = {}
    currentKey = undefined
    index = 0
    while index < length
      currentKey = keys[index]
      results[currentKey] = iteratee(obj[currentKey], currentKey, obj)
      index++
    results

  # Convert an object into a list of `[key, value]` pairs.

  _.pairs = (obj) ->
    keys = _.keys(obj)
    length = keys.length
    pairs = Array(length)
    i = 0
    while i < length
      pairs[i] = [
        keys[i]
        obj[keys[i]]
      ]
      i++
    pairs

  # Invert the keys and values of an object. The values must be serializable.

  _.invert = (obj) ->
    result = {}
    keys = _.keys(obj)
    i = 0
    length = keys.length
    while i < length
      result[obj[keys[i]]] = keys[i]
      i++
    result

  # Return a sorted list of the function names available on the object.
  # Aliased as `methods`
  _.functions =
  _.methods = (obj) ->
    names = []
    for key of obj
      if _.isFunction(obj[key])
        names.push key
    names.sort()

  # Extend a given object with all the properties in passed-in object(s).
  _.extend = createAssigner(_.allKeys)
  # Assigns a given object with all the own properties in the passed-in object(s)
  # (https://developer.mozilla.org/docs/Web/JavaScript/Reference/Global_Objects/Object/assign)
  _.extendOwn = _.assign = createAssigner(_.keys)
  # Returns the first key on an object that passes a predicate test

  _.findKey = (obj, predicate, context) ->
    predicate = cb(predicate, context)
    keys = _.keys(obj)
    key = undefined
    i = 0
    length = keys.length
    while i < length
      key = keys[i]
      if predicate(obj[key], key, obj)
        return key
      i++
    return

  # Return a copy of the object only containing the whitelisted properties.

  _.pick = (object, oiteratee, context) ->
    result = {}
    obj = object
    iteratee = undefined
    keys = undefined
    if obj == null
      return result
    if _.isFunction(oiteratee)
      keys = _.allKeys(obj)
      iteratee = optimizeCb(oiteratee, context)
    else
      keys = flatten(arguments, false, false, 1)

      iteratee = (value, key, obj) ->
        key of obj

      obj = Object(obj)
    i = 0
    length = keys.length
    while i < length
      key = keys[i]
      value = obj[key]
      if iteratee(value, key, obj)
        result[key] = value
      i++
    result

  # Return a copy of the object without the blacklisted properties.

  _.omit = (obj, iteratee, context) ->
    if _.isFunction(iteratee)
      iteratee = _.negate(iteratee)
    else
      keys = _.map(flatten(arguments, false, false, 1), String)

      iteratee = (value, key) ->
        !_.contains(keys, key)

    _.pick obj, iteratee, context

  # Fill in a given object with default properties.
  _.defaults = createAssigner(_.allKeys, true)
  # Creates an object that inherits from the given prototype object.
  # If additional properties are provided then they will be added to the
  # created object.

  _.create = (prototype, props) ->
    result = baseCreate(prototype)
    if props
      _.extendOwn result, props
    result

  # Create a (shallow-cloned) duplicate of an object.

  _.clone = (obj) ->
    if !_.isObject(obj)
      return obj
    if _.isArray(obj) then obj.slice() else _.extend({}, obj)

  # Invokes interceptor with the obj, and then returns obj.
  # The primary purpose of this method is to "tap into" a method chain, in
  # order to perform operations on intermediate results within the chain.

  _.tap = (obj, interceptor) ->
    interceptor obj
    obj

  # Returns whether an object has a given set of `key:value` pairs.

  _.isMatch = (object, attrs) ->
    keys = _.keys(attrs)
    length = keys.length
    if object == null
      return !length
    obj = Object(object)
    i = 0
    while i < length
      key = keys[i]
      if attrs[key] != obj[key] or !(key of obj)
        return false
      i++
    true

  # Internal recursive comparison function for `isEqual`.

  eq = (a, b, aStack, bStack) ->
    # Identical objects are equal. `0 === -0`, but they aren't identical.
    # See the [Harmony `egal` proposal](http://wiki.ecmascript.org/doku.php?id=harmony:egal).
    if a == b
      return a != 0 or 1 / a == 1 / b
    # A strict comparison is necessary because `null == undefined`.
    if a == null or b == null
      return a == b
    # Unwrap any wrapped objects.
    if a instanceof _
      a = a._wrapped
    if b instanceof _
      b = b._wrapped
    # Compare `[[Class]]` names.
    className = toString.call(a)
    if className != toString.call(b)
      return false
    switch className
      # Strings, numbers, regular expressions, dates, and booleans are compared by value.
      # RegExps are coerced to strings for comparison (Note: '' + /a/i === '/a/i')
      when '[object RegExp]', '[object String]'
        # Primitives and their corresponding object wrappers are equivalent; thus, `"5"` is
        # equivalent to `new String("5")`.
        return '' + a == '' + b
      when '[object Number]'
        # `NaN`s are equivalent, but non-reflexive.
        # Object(NaN) is equivalent to NaN
        if +a != +a
          return +b != +b
        # An `egal` comparison is performed for other numeric values.
        return if +a == 0 then 1 / +a == 1 / b else +a == +b
      when '[object Date]', '[object Boolean]'
        # Coerce dates and booleans to numeric primitive values. Dates are compared by their
        # millisecond representations. Note that invalid dates with millisecond representations
        # of `NaN` are not equivalent.
        return +a == +b
    areArrays = className == '[object Array]'
    if !areArrays
      if typeof a != 'object' or typeof b != 'object'
        return false
      # Objects with different constructors are not equivalent, but `Object`s or `Array`s
      # from different frames are.
      aCtor = a.constructor
      bCtor = b.constructor
      if aCtor != bCtor and !(_.isFunction(aCtor) and aCtor instanceof aCtor and _.isFunction(bCtor) and bCtor instanceof bCtor) and 'constructor' of a and 'constructor' of b
        return false
    # Assume equality for cyclic structures. The algorithm for detecting cyclic
    # structures is adapted from ES 5.1 section 15.12.3, abstract operation `JO`.
    # Initializing stack of traversed objects.
    # It's done here since we only need them for objects and arrays comparison.
    aStack = aStack or []
    bStack = bStack or []
    length = aStack.length
    while length--
      # Linear search. Performance is inversely proportional to the number of
      # unique nested structures.
      if aStack[length] == a
        return bStack[length] == b
    # Add the first object to the stack of traversed objects.
    aStack.push a
    bStack.push b
    # Recursively compare objects and arrays.
    if areArrays
      # Compare array lengths to determine if a deep comparison is necessary.
      length = a.length
      if length != b.length
        return false
      # Deep compare the contents, ignoring non-numeric properties.
      while length--
        if !eq(a[length], b[length], aStack, bStack)
          return false
    else
      # Deep compare objects.
      keys = _.keys(a)
      key = undefined
      length = keys.length
      # Ensure that both objects contain the same number of properties before comparing deep equality.
      if _.keys(b).length != length
        return false
      while length--
        # Deep compare each member
        key = keys[length]
        if !(_.has(b, key) and eq(a[key], b[key], aStack, bStack))
          return false
    # Remove the first object from the stack of traversed objects.
    aStack.pop()
    bStack.pop()
    true

  # Perform a deep comparison to check if two objects are equal.

  _.isEqual = (a, b) ->
    eq a, b

  # Is a given array, string, or object empty?
  # An "empty" object has no enumerable own-properties.

  _.isEmpty = (obj) ->
    if obj == null
      return true
    if isArrayLike(obj) and (_.isArray(obj) or _.isString(obj) or _.isArguments(obj))
      return obj.length == 0
    _.keys(obj).length == 0

  # Is a given value a DOM element?

  _.isElement = (obj) ->
    ! !(obj and obj.nodeType == 1)

  # Is a given value an array?
  # Delegates to ECMA5's native Array.isArray
  _.isArray = nativeIsArray or (obj) ->
    toString.call(obj) == '[object Array]'
  # Is a given variable an object?

  _.isObject = (obj) ->
    type = typeof obj
    type == 'function' or type == 'object' and ! !obj

  # Add some isType methods: isArguments, isFunction, isString, isNumber, isDate, isRegExp, isError.
  _.each [
    'Arguments'
    'Function'
    'String'
    'Number'
    'Date'
    'RegExp'
    'Error'
  ], (name) ->

    _['is' + name] = (obj) ->
      toString.call(obj) == '[object ' + name + ']'

    return
  # Define a fallback version of the method in browsers (ahem, IE < 9), where
  # there isn't any inspectable "Arguments" type.
  if !_.isArguments(arguments)

    _.isArguments = (obj) ->
      _.has obj, 'callee'

  # Optimize `isFunction` if appropriate. Work around some typeof bugs in old v8,
  # IE 11 (#1621), and in Safari 8 (#1929).
  if typeof /./ != 'function' and typeof Int8Array != 'object'

    _.isFunction = (obj) ->
      typeof obj == 'function' or false

  # Is a given object a finite number?

  _.isFinite = (obj) ->
    isFinite(obj) and !isNaN(parseFloat(obj))

  # Is the given value `NaN`? (NaN is the only number which does not equal itself).

  _.isNaN = (obj) ->
    _.isNumber(obj) and obj != +obj

  # Is a given value a boolean?

  _.isBoolean = (obj) ->
    obj == true or obj == false or toString.call(obj) == '[object Boolean]'

  # Is a given value equal to null?

  _.isNull = (obj) ->
    obj == null

  # Is a given variable undefined?

  _.isUndefined = (obj) ->
    obj == undefined

  # Shortcut function for checking if an object has a given property directly
  # on itself (in other words, not on a prototype).

  _.has = (obj, key) ->
    obj != null and hasOwnProperty.call(obj, key)

  # Utility Functions
  # -----------------
  # Run Underscore.js in *noConflict* mode, returning the `_` variable to its
  # previous owner. Returns a reference to the Underscore object.

  _.noConflict = ->
    root._ = previousUnderscore
    this

  # Keep the identity function around for default iteratees.

  _.identity = (value) ->
    value

  # Predicate-generating functions. Often useful outside of Underscore.

  _.constant = (value) ->
    ->
      value

  _.noop = ->

  _.property = property
  # Generates a function for a given object that returns a given property.

  _.propertyOf = (obj) ->
    if obj == null then (->
    ) else ((key) ->
      obj[key]
    )

  # Returns a predicate for checking whether an object has a given set of
  # `key:value` pairs.
  _.matcher =
  _.matches = (attrs) ->
    attrs = _.extendOwn({}, attrs)
    (obj) ->
      _.isMatch obj, attrs

  # Run a function **n** times.

  _.times = (n, iteratee, context) ->
    accum = Array(Math.max(0, n))
    iteratee = optimizeCb(iteratee, context, 1)
    i = 0
    while i < n
      accum[i] = iteratee(i)
      i++
    accum

  # Return a random integer between min and max (inclusive).

  _.random = (min, max) ->
    if max == null
      max = min
      min = 0
    min + Math.floor(Math.random() * (max - min + 1))

  # A (possibly faster) way to get the current timestamp as an integer.
  _.now = Date.now or ->
    (new Date).getTime()
  # List of HTML entities for escaping.
  escapeMap = 
    '&': '&amp;'
    '<': '&lt;'
    '>': '&gt;'
    '"': '&quot;'
    '\'': '&#x27;'
    '`': '&#x60;'
  unescapeMap = _.invert(escapeMap)
  # Functions for escaping and unescaping strings to/from HTML interpolation.

  createEscaper = (map) ->

    escaper = (match) ->
      map[match]

    # Regexes for identifying a key that needs to be escaped
    source = '(?:' + _.keys(map).join('|') + ')'
    testRegexp = RegExp(source)
    replaceRegexp = RegExp(source, 'g')
    (string) ->
      string = if string == null then '' else '' + string
      if testRegexp.test(string) then string.replace(replaceRegexp, escaper) else string

  _.escape = createEscaper(escapeMap)
  _.unescape = createEscaper(unescapeMap)
  # If the value of the named `property` is a function then invoke it with the
  # `object` as context; otherwise, return it.

  _.result = (object, property, fallback) ->
    value = if object == null then undefined else object[property]
    if value == undefined
      value = fallback
    if _.isFunction(value) then value.call(object) else value

  # Generate a unique integer id (unique within the entire client session).
  # Useful for temporary DOM ids.
  idCounter = 0

  _.uniqueId = (prefix) ->
    id = ++idCounter + ''
    if prefix then prefix + id else id

  # By default, Underscore uses ERB-style template delimiters, change the
  # following template settings to use alternative delimiters.
  _.templateSettings =
    evaluate: /<%([\s\S]+?)%>/g
    interpolate: /<%=([\s\S]+?)%>/g
    escape: /<%-([\s\S]+?)%>/g
  # When customizing `templateSettings`, if you don't want to define an
  # interpolation, evaluation or escaping regex, we need one that is
  # guaranteed not to match.
  noMatch = /(.)^/
  # Certain characters need to be escaped so that they can be put into a
  # string literal.
  escapes = 
    '\'': '\''
    '\\': '\\'
    '\u000d': 'r'
    '\n': 'n'
    '\u2028': 'u2028'
    '\u2029': 'u2029'
  escaper = /\\|'|\r|\n|\u2028|\u2029/g

  escapeChar = (match) ->
    '\\' + escapes[match]

  # JavaScript micro-templating, similar to John Resig's implementation.
  # Underscore templating handles arbitrary delimiters, preserves whitespace,
  # and correctly escapes quotes within interpolated code.
  # NB: `oldSettings` only exists for backwards compatibility.

  _.template = (text, settings, oldSettings) ->
    if !settings and oldSettings
      settings = oldSettings
    settings = _.defaults({}, settings, _.templateSettings)
    # Combine delimiters into one regular expression via alternation.
    matcher = RegExp([
      (settings.escape or noMatch).source
      (settings.interpolate or noMatch).source
      (settings.evaluate or noMatch).source
    ].join('|') + '|$', 'g')
    # Compile the template source, escaping string literals appropriately.
    index = 0
    source = '__p+=\''
    text.replace matcher, (match, escape, interpolate, evaluate, offset) ->
      source += text.slice(index, offset).replace(escaper, escapeChar)
      index = offset + match.length
      if escape
        source += '\'+\n((__t=(' + escape + '))==null?\'\':_.escape(__t))+\n\''
      else if interpolate
        source += '\'+\n((__t=(' + interpolate + '))==null?\'\':__t)+\n\''
      else if evaluate
        source += '\';\n' + evaluate + '\n__p+=\''
      # Adobe VMs need the match returned to produce the correct offest.
      match
    source += '\';\n'
    # If a variable is not specified, place data values in local scope.
    if !settings.variable
      source = 'with(obj||{}){\n' + source + '}\n'
    source = 'var __t,__p=\'\',__j=Array.prototype.join,' + 'print=function(){__p+=__j.call(arguments,\'\');};\n' + source + 'return __p;\n'
    try
      render = new Function(settings.variable or 'obj', '_', source)
    catch e
      e.source = source
      throw e

    template = (data) ->
      render.call this, data, _

    # Provide the compiled source as a convenience for precompilation.
    argument = settings.variable or 'obj'
    template.source = 'function(' + argument + '){\n' + source + '}'
    template

  # Add a "chain" function. Start chaining a wrapped Underscore object.

  _.chain = (obj) ->
    instance = _(obj)
    instance._chain = true
    instance

  # OOP
  # ---------------
  # If Underscore is called as a function, it returns a wrapped object that
  # can be used OO-style. This wrapper holds altered versions of all the
  # underscore functions. Wrapped objects may be chained.
  # Helper function to continue chaining intermediate results.

  result = (instance, obj) ->
    if instance._chain then _(obj).chain() else obj

  # Add your own custom functions to the Underscore object.

  _.mixin = (obj) ->
    _.each _.functions(obj), (name) ->
      func = _[name] = obj[name]

      _.prototype[name] = ->
        args = [ @_wrapped ]
        push.apply args, arguments
        result this, func.apply(_, args)

      return
    return

  # Add all of the Underscore functions to the wrapper object.
  _.mixin _
  # Add all mutator Array functions to the wrapper.
  _.each [
    'pop'
    'push'
    'reverse'
    'shift'
    'sort'
    'splice'
    'unshift'
  ], (name) ->
    method = ArrayProto[name]

    _.prototype[name] = ->
      obj = @_wrapped
      method.apply obj, arguments
      if (name == 'shift' or name == 'splice') and obj.length == 0
        delete obj[0]
      result this, obj

    return
  # Add all accessor Array functions to the wrapper.
  _.each [
    'concat'
    'join'
    'slice'
  ], (name) ->
    method = ArrayProto[name]

    _.prototype[name] = ->
      result this, method.apply(@_wrapped, arguments)

    return
  # Extracts the result from a wrapped and chained object.

  _::value = ->
    @_wrapped

  # Provide unwrapping proxy for some methods used in engine operations
  # such as arithmetic and JSON stringification.
  _::valueOf = _::toJSON = _::value

  _::toString = ->
    '' + @_wrapped

  # AMD registration happens at the end for compatibility with AMD loaders
  # that may not enforce next-turn semantics on modules. Even though general
  # practice for AMD registration is to be anonymous, underscore registers
  # as a named module because, like jQuery, it is a base library that is
  # popular enough to be bundled in a third party lib, but not be part of
  # an AMD load request. Those cases could generate an error when an
  # anonymous define() is called outside of a loader request.
  if typeof define == 'function' and define.amd
    define 'underscore', [], ->
      _
  return
).call this

# ---
# generated by js2coffee 2.2.0
