rivets.binders.input =
  publishes: true
  routine: rivets.binders.value.routine
  bind: (el) ->
    el.addEventListener('input', this.publish)
  unbind: (el) ->
    el.removeEventListener('input', this.publish)

rivets.configure
  prefix: "rv"
  adapter:
    subscribe: (obj, keypath, callback) ->
      callback.wrapped = (m, v) -> callback(v)
      obj.on('change:' + keypath, callback.wrapped)

    unsubscribe: (obj, keypath, callback) ->
      obj.off('change:' + keypath, callback.wrapped)

    read: (obj, keypath) ->
      if keypath is "cid" then return obj.cid
      obj.get(keypath)

    publish: (obj, keypath, value) ->
      if obj.cid
        obj.set(keypath, value);
      else
        obj[keypath] = value
rivets.formatters.number =
  read: (value) ->
    if value && value != '' then return parseInt(value) else return undefined;
  publish: (value) ->
    if value && value != '' then return parseInt(value) else return undefined;
