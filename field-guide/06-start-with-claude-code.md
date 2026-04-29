# Field Guide 06 — Five exercises for weeks one and two

Companion to Chapter 6, *Start With Claude Code.*

The chapter is the on-ramp. Why Claude Code specifically. What the first two weeks actually feel like. Don't form a committee. Don't pilot. Don't delegate the setup. This guide is the five things you do, in order, to land week one.

Block one hour for the first sitting. Exercises 4 and 5 spread across week two.

## Exercise 1 — Install

Install Claude Code on the machine you actually work on. Not a sandbox laptop. Not your kid's old MacBook. The machine where your real work lives.

Run `claude` once from a project directory you care about. Ask it to summarize the directory in plain English. Read what comes back.

Time: ten minutes. Success criterion: you saw Claude Code read your real work.

## Exercise 2 — Bootstrap from slopless

[Slopless](https://github.com/BioInfo/slopless) is a starter scaffolding for Claude Code: rules, hooks, statusline, a base `CLAUDE.md`. Copying it gives you a working rig in five minutes instead of three weeks of trial and error.

Clone slopless into a fresh directory, or merge the relevant pieces into your `~/.claude/` configuration. Open the result. Read the rules and the base CLAUDE.md once.

Time: fifteen minutes. Success criterion: you have a working baseline you didn't have to invent.

## Exercise 3 — Rewrite something you already wrote

Pick a memo, an email draft, a one-pager, or a slide-track narrative you wrote in the last month. Open it in Claude Code. Ask Claude to make it sharper, in your voice, against a tier-2 register.

Read what comes back. Redirect once. Read again. Keep the version you'd actually send.

Time: twenty minutes. Success criterion: the artifact got better and you noticed where Claude pushed back on you.

## Exercise 4 — Write your first skill

A skill is a repeatable instruction set Claude Code follows when invoked. The minimal version is a single markdown file: name, description, procedure.

Write a skill for the most repetitive prompt-style task in your week. Common examples for executives: "draft a meeting summary in my voice from these notes," "rewrite this for a senior audience," "produce a one-pager from this brief." Save it. Use it. Iterate the markdown when it misfires.

Time: thirty minutes spread across week two. Success criterion: you used the skill at least three times and tightened the markdown each time.

## Exercise 5 — Write your first guardrail

A guardrail is a hook or rule that prevents a class of mistake. The simplest version is a one-line addition to `CLAUDE.md`: "never send communications without explicit approval," "never commit secrets," "always cite sources for claims of fact."

Write one guardrail that addresses something you've already seen go wrong. Save it. Notice the next time it fires.

Time: ten minutes. Success criterion: a guardrail exists that wasn't there before, and it caught at least one thing.

## After

By the end of week two, you have installed Claude Code, bootstrapped from a starter, rewritten a real artifact, written a skill you use, and written a guardrail that fires. That's the on-ramp. Field Guide 07 is what you do for the next month.
