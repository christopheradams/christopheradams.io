---
layout: post
title: "New Router features in Plug 1.3"
category: articles
location: Taipei
---

*Plug v1.3.0 has just been released. Read on for a couple of interesting new
features.*

[Plug][Plug] is a simple specification and powerful library for writing
composable web modules in [Elixir][Elixir]. While it underpins the
popular [Phoenix Framework][Phoenix], it also tends to get over-shadowed.  And
yet, Plug is very capable on its own, and has a couple of new features that are
helping it to pull even.

Some background: the Plug module "specification" has only two functions:
`call/2`, which takes a connection struct and set of options, and returns the
connection; and `init/1`, which takes a set of options and initializes it.

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
will accept *any* Plug module. This means that you are not limited to defining
your resources using the strict Controller pattern.

Plug's Router has been deprived of this feature, until now. Starting in v1.3.0,
you can dispatch requests directly to a Plug module:

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

### Path Params

One final minor, but crucial new feature is that for all match macros in Plug's
Router, the resulting connection struct will have a `conn.path_params` map that
holds any dynamic path values. These will also be saved in `conn.params`,
similar to what you see in Phoenix.

The [Plug Router docs](plug-router-docs) have all the details.

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
