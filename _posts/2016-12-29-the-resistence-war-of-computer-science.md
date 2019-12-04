---
title: The Resistance War of Computer Science
category: articles
tags: programming
excerpt: Object Lessons of History
location: Hanoi
image: https://upload.wikimedia.org/wikipedia/commons/thumb/c/c6/Hano%C3%AFLePetitLacVers1900.jpg/640px-Hano%C3%AFLePetitLacVers1900.jpg
---

<span class="byline">*Hoàn Kiếm Lake* (c. 1900), [Wikipedia][Hoan Kiem Lake].</span>

> If the [hardest thing in Computer Science][TwoHardThings] is naming things,
> then a corollary rule is that misnaming things must be the easiest.

One of the more evocative similes in my field is Ted Neward's notion that
"Object/relational mapping is [the Vietnam of Computer Science]."
It's an analogy for the mismatch between the representation of data in **object
systems** (in terms of [OOP] languages) and **relational systems** (*i.e.*,
relational databases) and the hazards of translating between them.

The thrust of the metaphor is that the **O/R-M** problem, like the Vietnam War,
is a quagmire that might have started as planned but quickly got bogged down in
complications with no solution and no exit strategy in sight.

It's rueful to think on this problem from Hanoi, where the real Vietnam War was
experienced from the opposing side, and known by another name entirely, as
*Kháng chiến chống Mỹ*, or the **Resistance War Against America**.

Neward later [acknowledged][Thoughts on Vietnam commentary] that his analogy
might seem strained and even offensive. I don't wish to defend it, or dismiss
it.
Nevertheless, an analysis of his argument, like the War itself, would benefit
from a similar shift in perspective.

Neward's stance on the O/R-M problem takes an object-oriented approach for
granted, rather than deconstructing it;
much like his metaphor of the Vietnam War assumes its name and meaning in an
American context.

It has been over a decade since *The Vietnam of Computer Science* was
published. In that time the industry has had a chance to learn its own lessons
from history, such as the advantages of message-passing, share-nothing,
process-oriented architectures (like [Erlang]) which make better object systems
than OOP does;
and functional languages which manipulate lists and sets of data in a way that
is aligned with the operators of relational algebra.

Neward proposes one solution to the O/R-M problem that he can't accept in the
end, to give up on objects entirely.
Ironically, it is the same conclusion that the U.S. came to in its prosecution
of the war effort in Vietnam: **abandonment**.

[Erlang]: http://www.erlang.org/
[Hoan Kiem Lake]: https://commons.wikimedia.org/w/index.php?curid=21726338
[OOP]: https://en.wikipedia.org/wiki/Object-oriented_programming
[The Vietnam of Computer Science]: http://blogs.tedneward.com/post/the-vietnam-of-computer-science/
[Thoughts on Vietnam commentary]: http://blogs.tedneward.com/post/thoughts-on-vietnam-commentary/
[TwoHardThings]: https://martinfowler.com/bliki/TwoHardThings.html
