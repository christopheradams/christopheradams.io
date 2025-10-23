---
title: New Router features in Plug 1.3
description: Calling All Plugs
published_at: 2016-11-28 19:31:13 +0800
category: Articles
tags: [Programming]
image: /assets/images/20180604-20180604_Taipei_elixirtw_L1002146-0.jpg
location: Taipei
published: false
---

> Plug v1.3.0 has just been released. Read on for a couple of interesting new
> features.

[Plug][Plug] is a simple specification and powerful library for writing
composable web modules in [Elixir][Elixir]. While it underpins the
popular [Phoenix Framework][Phoenix], it also tends to get over-shadowed.  And
yet, Plug is very capable on its own, and has a couple of new features that are
helping it to pull even.

Here is an example of a module that satisfies the Plug spec. It only needs to
export two functions: `init/1` and `call/2`.

```elixir
defmodule HelloPlug do
  import Plug.Conn

  def init(opts) do
    opts
  end

  def call(conn, _opts) do
    send_resp(conn, 200, "hello")
  end
end
```

### Routers

The centerpiece of most web frameworks is the router. It provides the bridge
between the framework's code and the user's by dispatching each request
(identified by a URL path) to a designated resource implementation. In most
Elixir web frameworks, the router provides an approachable [DSL][DSL] for
defining the routing structure. Plug is no exception here.

Since version 1.0, Plug's Router has had a DSL reminiscent of [Sinatra]. It
defines a macro for each HTTP verb, which matches a URL path and executes a body
of code operating on the connection.

```elixir
defmodule MyApp.Router do
  use Plug.Router

  plug :match
  plug :dispatch

  get "/hello" do
    send_resp(conn, 200, "world")
  end
end
```

In contrast, Phoenix's Router is more in the style of [Ruby on Rails][RoR]. It
dispatches each request to an action function in a Controller module.

```elixir
defmodule MyApp.Router do
  use HelloPhoenix.Web, :router

  get "/hello", HelloController, :show
end
```

Underneath, both Plug and Phoenix's routers implement the Plug module
specification. However, in the case of Phoenix, an extra bit of cleverness lurks
behind its [MVC][MVC] facade: Controllers are Plugs! In fact, the router macros
will accept *any* Plug module.
We could, for example, change the route to:

```elixir
get "/hello", HelloPlug, [an_option: :a_value]
```

Plug's Router has been deprived of a feature like this, until now.
Starting in v1.3.0, you can dispatch requests directly to a Plug module:

```elixir
get "/hello", to: HelloPlug, init_opts: [an_option: :a_value]
```

This is equivalent to:

```elixir
get "/hello" do
  HelloPlug.call(conn, HelloPlug.init([an_option: :a_value]))
end
```

While a seemingly small change, this feature will make it both easier and more
likely for us to build Controller-like patterns directly on top of Plug Router.
With it you can factor out the code that handles each route into separate
modules, rather than filling up your router with function bodies.

### Path Params

Plug Router's routes have always supported dynamic path segments, such as:

```elixir
get "/hello/:name" do
  send_resp(conn, 200, "hello #{name}")
end
```

The `:name` parameter can be used directly as a variable in the function body
passed to the match macro. In order to make these values available generally in
the connection, Plug 1.3 has added a `conn.path_params` map to hold them. They
will also be saved in `conn.params`, a behavior which will be familiar to
Phoenix users.

The [Plug Router docs][plug-router-docs] have all the details.

**P.S.** The reason I decided to blog about these new Plug features is because I
wrote them!

[Plug]: https://github.com/elixir-lang/plug
[Elixir]: http://elixir-lang.org/
[Phoenix]: http://www.phoenixframework.org/
[DSL]: https://en.wikipedia.org/wiki/Domain-specific_language
[Sinatra]: http://www.sinatrarb.com/
[RoR]: http://rubyonrails.org/
[MVC]: https://en.wikipedia.org/wiki/Model%E2%80%93view%E2%80%93controller#Use_in_web_applications
[plug-router-docs]: https://hexdocs.pm/plug/Plug.Router.html
