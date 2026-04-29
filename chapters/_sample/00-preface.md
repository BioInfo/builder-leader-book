<!--
This is the full preface from *Builder-Leader: The AI Exoskeleton That Crosses
the Gap*. It is published here as a reading sample under the CC BY-NC-ND 4.0
license. The remaining ten chapters are gated. See README.md for the buy link.
-->

# Preface {-}

Two years ago, my kids showed me a website called 11:11 Make a Wish. You typed a wish at 11:11 and the site would hold it for you. They loved it. I loved that they loved it. So I decided to make my own version for the App Store. I called it 11:11 Make a Fish. A fish, because fish were funnier than wishes to an eight-year-old.

It took me the better part of two weeks.

I was using Cursor at the time. It was autocomplete. A good autocomplete, the kind that was starting to write small stretches of code more autonomously, and that felt like the frontier. I was typing. I was the one at the keyboard. Cursor helped me type faster and read unfamiliar files more easily, but the fingers on the keys were mine and the work was coding. My floor was not zero; I had a technical background behind those fingers, which is worth naming so the before-and-after arc in this preface reads accurately. The book is written for the reader whose floor is further back than mine was. The argument is that the crossing is now available from that starting line too, and the rest of the book makes the case. Two weeks to ship a joke app for my kids felt, honestly, fast.

This weekend, in April 2026, I did five things.

I started writing this book. I wrote a blog post explaining a machine learning system we built for estimating which genetic variants cause cancer in patients. I produced the complete DNA sequence analysis pipeline that blog post describes, not as a demo but as the real thing. I shipped a commercial domain discovery tool called Nymio, built across a multi-model backend, one weekend from nothing to a working product. And I built a multi-agent portfolio system that would previously have been a multi-month engineering effort.

I did not write any of the code. I wrote a lot of instructions (specs, redirections, corrections, review notes) and directed Claude Code to do the coding. I described what I wanted, I read what came back, I redirected, I let agents run in parallel, I assembled what they produced into a working whole. Two of the five needed me to stop, pull the agent back, and start over on a different approach. That is part of directing. Five artifacts, one weekend, zero lines of code typed by me.

That is the shift the rest of this preface is about. Make a Fish was coding, assisted. Nymio was directing, and the coding was something the system did because I told it to.

## The curve

The honest version of the story is that Make a Fish, two weeks, a toy, autocomplete, is on one side of something. The weekend I just described is on the other side. The something in between is not a better model, or a better IDE, or a new framework. All of those help. None of them explain the gap.

What changed is the way the work is done. I am no longer typing code and watching autocomplete help. I am directing a system that builds the thing. Sometimes I watch. Sometimes I leave and come back. Sometimes I run four of them in parallel. The artifact I started the weekend with was a blank directory. The artifact I ended with was a commercial product.

From the outside this looks like hype. From the inside it looks like a curve. It went from months to days. The compounding keeps going. The bottleneck has moved from "can the system build it" to "can I review and redirect fast enough." That is a very different bottleneck, and I do not know where it ends.

## The gap

Most people reading this sentence have not crossed it yet.

You may be using Cursor autocomplete, or ChatGPT in a browser tab, or Claude in a paid subscription that you check in on once a week. You may be sponsoring an AI center of excellence at your company. You may be asking your team to come back with use cases. You may have watched a vendor demo last month that made you feel behind. You may be reading this book because the people you trust keep telling you this matters and you want a frame you can act on.

I was in that exact seat two years ago. So were most of the people I now trade notes with who have crossed. Many of us came from technical backgrounds; the crossing is now available from non-technical starting lines too, and the rest of the book is the case for that. None of us woke up one day fundamentally different from the people who haven't. What happened is that we, in small steps, started doing the work differently, and the compounding took over from there.

The book you are reading is an operator's manual for that crossing. Not a think piece, not a landscape tour, not a case-study collection. A ladder. Three months to the other side if you start Monday. Six at the outside if you are starting from further back. After that, the curve I just described is not a thing you read about. It is a thing you live inside.

The ladder does not care about your starting polish. It cares about the climb. The climb is available to any leader whose surface and density match.

The book draws heavily from a coherent intellectual tradition. Karpathy, Mollick, Fowler, Anthropic's research posts, the operator community on X and HN. That tradition is producing the work the book is documenting. Counter-traditions exist; they are engaged where they make load-bearing arguments.

## The friction

There is one thing that will try to stop you, and it is not technical.

It is the shape of the room you sit in. Most large organizations still hold a narrow view of what a senior business leader is. That view was formed in an era when technical work was what engineers did inside IT, and business work was what leaders did inside business units, and the two tracks ran parallel without touching. In that era, the classification worked. In 2026, it does not. The senior business leader who can personally direct a harness to produce technical artifacts inside their domain is a category the institution does not yet have a slot for.

Gartner has a formal name for the category. Its Business Technologist role, updated in 2026 to include orchestration of autonomous agentic workflows, covers employees outside central IT who create technology capabilities. Its related Fusion Team concept (multidisciplinary IT-plus-business teams) now runs inside eighty-four percent of companies by Gartner's own 2026 data. These are bureaucratic names on the org chart. The executive-hiring market is reaching for its own vocabulary in parallel, without consensus. Charles Schwab's April 2026 Director-level posting in its Broker Dealer Services Engineering group asks for "Agentic AI Modernization Experience" and promises the candidate "fingerprints on the strategy, architecture, and ways of working." Industry discourse has offered "AI-native executive," "player-coach," "T-shaped leader," and "hybrid leader" as candidate names for the same seat. The institutional slot is not built yet. The people filling it are filling it as they go.

The friction plays out in real time. People who can direct a harness to build production-grade systems get slotted into technical-advisor roles because the institution cannot imagine them running the business. Polished VPs inherit AI portfolios they cannot operate, because the institution cannot imagine a VP with technical capability. I have sat in rooms where someone senior said, with a straight face, that technical capability at my altitude is a category error, not a competence. That is not a scene from ten years ago. That is a scene from this year.

If you are already a senior executive, the friction will show up as a tug. Part of you will want to cross. Part of you will have been trained, explicitly and repeatedly, to treat technical capability as somebody else's job. You will feel, in your own body, the pull of an institution that does not know how to promote what you are about to become.

If you are the person below the senior executive, the friction looks different. The institution has told you, not always in words, that leadership requires stepping away from anything technical. The weekend I described above is evidence that is wrong. In 2026, the most valuable senior leaders are the ones who can direct the harness themselves.

If you are a senior leader who will not personally build technical artifacts because your portfolio is too wide, the friction still lands on you, but it lands differently. The institution does not have a slot for the builder-leader you are about to hire or already employ. Your job now is to make one. The book gives you the language. Chapter 9 defends builder-leader as a permanent role rather than a transitional one.

This book is written in full view of all three versions of that friction. The crossing and the identity resolution are the same book.

## The landing

Three months from now, if you work through the ladder, you will have done four specific things. You will have directed Claude Code, or a similar harness, to build something real for your domain. You will operate a personal harness: skills you specified and tuned, memory you maintain, agents you spawned, hooks you configured, sensors you calibrated. You will have shipped something through that harness that your business would have otherwise bought from a vendor or done without. And you will have sat in a meeting where someone said something about AI that you knew, from your own operating experience, was wrong, and you will have corrected them without hedging.

The skills that get you there are not new. They are the same five leadership primitives you already use every day on people. The difference is that you will apply them to a multi-agent harness instead of a multi-human team. Same primitives. Different instrument. You are already most of the way there. You just do not know it yet, because nobody has pointed this at you. Chapter 5 names the five and shows the transfer in detail.

When the four things above have happened, the book has done its job.

The curve I am living on right now, five artifacts over a weekend, each of them something that used to be its own project, is not mine. I do not own it. It is available to anyone who is willing to spend three months climbing. The people already on it will welcome you. I can tell you this because I am one of them, and that is what we do now.

---

*This preface is from* Builder-Leader: The AI Exoskeleton That Crosses the Gap *by Justin Johnson. The full book is at the buy link in this repo's README.*
