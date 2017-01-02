---
layout: post
title: "Match All the Verbs"
description: "Phoenix is not your App. Is it even MVC?"
category: articles
tags: programming
location: Hanoi
---

> It turns out that Elixir's popular MVC web framework doesn't need Models,
> Views, or even Controllers.

I've never been an adherent of the [MVC] pattern in web applications, even
though it has been a productive structure for full-featured server-side
software.
Often I prefer to use [Webmachine] or an equivalent program in Erlang, Ruby, or
Clojure.
Other times I don't need an HTML template engine or a database wrapper.
Overall, I prefer to build up a web app piece by piece, instead of committing
up-front to an opinionated framework.

When working in Elixir, [Plug] suffices for the piecemeal approach.
Nevertheless, it's always tempting to use the more
capable [Phoenix Framework][Phoenix] for web development.

Although I can generate a Phoenix project without Models, or else encapsulate
them in a separate [OTP] application from my web app;
and although I can avoid Views by sending responses directly using Plug;
I didn't think I could escape from Phoenix's Controllers (without completely
replacing the Router);
that is, until [Chris McCord] gave me an insight that showed the way.

## Spelling W-E-B with M-V-C

Model–View–Controller (MVC) is a software design pattern that developed out of
early (desktop) graphical user interfaces but was later adapted to describe web
application frameworks, such as Ruby on Rails and, more recently, [Phoenix].

For server-side web software, [MVC] denotes the components that manage data
(*Models*), media representations (*Views*), and HTTP request/response behavior
(*Controllers*).
Nevertheless, the MVC pattern does not name its central component, the
**Router**, which is responsible for dispatching each request to a corresponding
"code path" that partly implements the resource.

Take a basic request line such as:

```http
GET /some HTTP/1.1
```

In Phoenix, a `GET` request for `/some` resource is matched using a router
macro:

```elixir
get "/some", SomeController, :index
```

This `get` macro call is equivalent to:

```elixir
match :get, "/some", SomeController, :index
```

Here, the arguments comprise an HTTP verb, a URL path, a Controller, and an
action function.
These four terms together define a "route" in Phoenix.
But do they have to?

## The Controller Pattern

The `match` macros in [Phoenix] Router are not limited to using a Phoenix
Controller.
Instead, they will accept any module that follows the [Plug] specification.

```elixir
match :get, "/plug", SomePlug, []
```

So, if a Phoenix route does not require a Controller, does that mean we can drop
the last letter of **MVC**?

*Not necessarily, and here's why.*

Because the role of the Router is often elided when we talk about Web MVC, it's
easy to miss its significance.
The Controller part of MVC is not just a `Controller` module that includes one
or more action functions.
Rather, it is a particular contract, enforced by the Router, for matching a
request with the code that will generate a response.
We can see this contract in the API for Phoenix's `match` macro:

```elixir
# Generates a route match based on an arbitrary HTTP method
match(verb, path, plug, plug_opts, options \\ [])
```

I argue that the real Controller Pattern is matching a **verb** and **path**, and
executing a **module/function** in the context of a **request**.

For most [CRUD] apps, the Controller Pattern suffices.
It might even seem easy.
But it is not ideal for every scenario, including but not limited to:

1. An echo server that replies to all requests for a path (for any HTTP method)
1. A REST-based framework where the HTTP methods supported for each resource are
   encoded in the connected Plug, and not the Router; *e.g.*, [PlugRest]

The Controller Pattern forces you to divide a resource (as identified by a URL
path) into multiple routes, split HTTP method logic between the Router and
Controllers, and re-implement core resource behavior (like "Not Found") in each
action function.
It does not allow a 1:1 mapping between Routes and Resource implementations.

*But Phoenix does.*

## Breaking the Pattern

I brought up method-agnostic Phoenix routes again in [a closed issue][977] on
the GitHub project page.
After some discussion, Chris McCord offered that Phoenix already supports this
behavior by way of a catch-all verb:

```elixir
match :*, "/any", SomePlug, []
```

The feature exists for use with the `forward` macro, but had not been publicly
endorsed for use with `match`.
Fortunately, it seems this feature may be documented in the next release of
Phoenix.
This finally allows us to drop the Controllers from our "MVC" web app.

## Doing It Wrong?

I was curious about the initial reluctance to fully support a catch-all `match`
macro in Phoenix Router, and how it could be "abused" or "introduce bad
behaviors".
I have a hunch it stems from a decision in Rails to [deprecate "match"][5964]
without a specified method (resolved in [this commit][56cdc81]).

Rails warns about the danger of unintentionally putting "state-changing" code
that manipulates resources on `GET`-accessible routes.
The [documentation][Rails match] advises that "You should not use the match
method in your router without specifying an HTTP method."
[Egor Homakov][Match in Rails and CSRF] is even more blunt, writing:

> You always know which HTTP Verb is used for specific "controller#action"! **If
> you don't - you are doing it wrong.**

This assumes, of course, that we are always and forever using the Controller Pattern.

Nevertheless, it's still possible to match all HTTP methods in a Rails route using an
explicit `via: :all` option. Fortunately, Phoenix offers us the same escape hatch.

## Game, Set, Match

Phoenix's flexibility and openness to multiple, co-existing patterns for
structuring web applications is just one more thing to recommend the framework.

*Phoenix is only MVC if you want it to be.*

[56cdc81]: https://github.com/rails/rails/commit/56cdc81c08b1847c5c1f699810a8c3b9ac3715a6
[5964]: https://github.com/rails/rails/issues/5964
[977]: https://github.com/phoenixframework/phoenix/issues/977
[CRUD]: https://en.wikipedia.org/wiki/Create,_read,_update_and_delete
[Chris McCord]: http://www.chrismccord.com/
[MVC]: https://en.wikipedia.org/wiki/Model%E2%80%93view%E2%80%93controller#Use_in_web_applications
[Match in Rails and CSRF]: http://homakov.blogspot.com/2012/04/whitelist-your-routes-match-is-evil.html
[OTP]: https://en.wikipedia.org/wiki/Open_Telecom_Platform
[Phoenix]: http://www.phoenixframework.org/
[Plug 1.3]: {% post_url 2016-11-28-new-router-features-in-plug-1-3 | prepend: site.url %}
[PlugRest]: https://github.com/christopheradams/plug_rest
[Plug]: http://hexdocs.pm/plug/
[REST]: https://en.wikipedia.org/wiki/Representational_state_transfer
[Rails match]: http://api.rubyonrails.org/classes/ActionDispatch/Routing/Mapper/Base.html#method-i-match
[Webmachine]: https://github.com/webmachine/webmachine
