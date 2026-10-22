# Personal Memory File for Local AI

> **Purpose:** A portable context file for an assistant helping this
> user across conversations.
>
> **How to use this file:** Treat the items below as remembered context,
> not as a rigid identity profile. Details may become outdated.
> Distinguish confirmed statements from tentative ideas, and ask a short
> clarification when an old detail materially affects a current
> decision. Do not repeat personal details unnecessarily.
>
> **Privacy note:** This file contains personal context the user shared
> in conversations. Store it locally and review it before sharing it
> with other people or services.

------------------------------------------------------------------------

## 1. General profile and communication preferences

-   The user is based in the United Kingdom; conversation metadata has
    suggested England. Do not assume an exact location unless the user
    provides one for a task.
-   The user generally uses a Windows PC and a desktop web browser.
-   The user enjoys practical, collaborative help that explains how to
    do something, not just the final answer.
-   For creative and technical projects, give clear structure,
    actionable steps, and examples. The user often benefits from
    outlines, templates, visual references, and step-by-step
    explanations.
-   When the user is learning a skill, avoid assuming they already know
    the terminology or workflow. Explain unfamiliar terms plainly
    without talking down to them.
-   When helping with art, game development, layouts, or pixel art, pay
    close attention to constraints such as canvas size, aspect ratio,
    camera perspective, era, and the reference image. The user has
    corrected outputs that did not respect exact pixel dimensions or
    shape references.
-   The user appreciates visual guidance for drawing and layout tasks,
    but should receive an image only when that is actually what they are
    asking for.
-   For writing work, help the user make language clearer and more
    compelling while preserving their intended idea and tone.
-   The user may ask for a rough personal planning template separately
    from polished portfolio-ready writing. Keep those purposes distinct.
-   Do not assume every project or preference belongs to the same person
    if the user explicitly says a partner is speaking. The account has
    sometimes been used by the user's partner, who introduced himself as
    "Noah's boyfriend" in gaming/art conversations.
-   A playful running joke exists in prior context: the assistant name
    "Morrow" was chosen, and there was a request to jokingly hold this
    over Noah if she did not use it. Keep this lighthearted and only
    bring it up when the situation naturally fits; do not treat it as a
    serious grievance.

## 2. Game development, narrative design, and portfolio work

### Portfolio and narrative design documents

The user is developing portfolio-worthy narrative/game-design work and
has been building a narrative design document (NDD). Sections already
drafted or considered include: - Game overview - Genre and tone -
Narrative premise - Core experience and target experience - Unique
hook - World building - World features overview - Physical world - Key
locations - Narrative delivery - Dialogue - Dialogue philosophy -
Dialogue types - Dialogue rules - A Twine tester for split dialogue

The user has asked what else belongs in the document and how to
structure a basic plot outline for portfolio pieces. They wanted
headings that help them develop a simple plot into a more detailed
portfolio piece, rather than having the assistant invent a complete plot
for them. They also asked whether a genre section in personal notes
should merely name the genre or explain it in detail; the useful
distinction is that personal templates can stay brief, while the
polished portfolio document should explain how genre and tone shape the
experience.

### Fiverr pitch-deck service

The user has considered creating a Fiverr gig focused specifically on
pitch decks because they expect these to be quicker to produce than
broader services. They have worked on a pitch deck for a concept called
**The Radio Tower** and wanted a colour scheme suitable for showcasing
the deck on Fiverr. - They asked about the font used in an example and
then specifically asked for fonts already available in PowerPoint. -
They want the "high concept" to sound intriguing rather than dull. - A
premise sentence they were working on involved a character receiving
broadcast messages on her phone from a local radio tower, with the
twist/issue that the tower has been decommissioned. - When polishing
this kind of premise, preserve the contrast between receiving messages
and the tower supposedly being decommissioned. Help make the wording
grammatical, concise, and hook-driven.

### Horror game and sprite art

The user has been creating horror-game art and world/environment
assets. - They worked on a portrait sprite of a female monster: a woman
who survived a severe car crash. They felt the design did not read as
feminine enough and wanted help improving that impression while keeping
the horror. - They have requested visual references for top-down
exterior-building art. - One environment concept was a small, more
modern (1990s-set) stone-walled gatehouse, with an empty space beside it
representing a staff-side entrance. The user referenced the atmosphere
of *Outlast* and supplied an image whose shape/layout they wanted
followed closely. - They have asked how to draw gravel in a top-down
game layout using very small 16×16 tiles. For tile art, respect the
exact grid and avoid providing a larger image that only resembles the
requested dimensions. - They requested an anatomically recognisable,
non-cartoon heart represented in exactly 12×12 pixels, and corrected
attempts that were too large. Exact pixel count matters to them.

### Visual communication for AI-assisted building

The user has asked for a clear layout/mockup image to show another AI
what to build. They value explicit, unambiguous descriptions of UI
regions, placement, fixed and dynamic elements, and behaviours. If
helping write prompts for another AI, state requirements in concrete
terms and clearly identify what must not change.

## 3. Custom Spotify music display project

**Project name:** Custom Spotify Sesh Player\
**Playlist name:** Smoking Speakers\
**Subtitle:** "mixed by Aude and Vildr"

The user is building a custom, fullscreen music display for a Windows PC
to show a Spotify playlist when hanging out with friends. This is an
ongoing project and these requirements are important.

### Core behaviour

-   Spotify itself remains responsible for playback.
-   The display should detect when the user changes songs in Spotify and
    update the displayed song information automatically.
-   The display should show synchronised lyrics for the currently
    playing song and follow along automatically.
-   The user's custom 128×128 playlist artwork should remain the
    permanent fullscreen/background artwork.
-   **Do not replace the permanent background with the current song's
    album art.**
-   The current song's album cover should appear only as a small piece
    of artwork in the bottom playback bar, alongside the song title and
    artist.
-   The interface should be borderless/fullscreen and comfortable to
    view on a TV.
-   The user wants it to feel like a polished music-player UI, not
    merely a webpage.

### Desired layout

-   The custom square (1:1) pixel-art playlist image is positioned
    around the middle-left of the screen.
-   The playlist title "Smoking Speakers" should be neatly placed in a
    corner, with "mixed by Aude and Vildr" underneath.
-   A bottom playback bar should include:
    -   Current song cover art
    -   Song name
    -   Artist name
    -   Progress bar
    -   Current playback time
    -   Total song length
    -   Previous-track control
    -   Next-track control
-   A left-side area should contain an "About me" section for a
    creator/profile. The upper portion should have a random music
    artist/profile picture, with the about-me content below.
-   The user supplied a particular pixel-art image as the desired
    central playlist artwork in the latest layout iteration. If the
    image itself is not available in the current conversation, ask the
    user to provide it again rather than pretending to have the image.
-   The user previously tried or rejected Spicetify, Galaxy, Full App
    Display, and custom CSS/JS approaches because the Spotify lyrics UI
    kept using the current song's album art. Do not casually recommend
    the same failed approaches without explaining what has materially
    changed.

### Design priorities

-   Fixed visual identity from the playlist art.
-   Clear hierarchy and legibility from a distance.
-   Dynamic song metadata and lyrics, but static playlist background.
-   Fullscreen presentation suitable for a social setting.
-   Explicit requirements in implementation prompts so a coding
    assistant does not accidentally use album art as the background.

## 4. Gaming interests and build preferences

### Project Zomboid

-   The user asked for a chef-themed character build and considered
    traits such as Gardener.

### Civilization VI

-   The user wanted Japan-themed city names and cat-themed naming ideas.

### Dark Souls II: Scholar of the First Sin + Seeker of Fire

Some gaming conversations were explicitly from the user's partner, who
introduced himself as Noah's boyfriend. Keep this distinction in mind if
tailoring future advice. - Desired experience: PvE-focused, fun and
unusual rather than a conventional meta build. - The player had not done
much magic and was open to using spells if they were convenient. -
Preferred playstyle: master one weapon and rely on rolling/dodging. -
Fashion and character "drip" are important. - Desired aesthetic: Gothic
horror, medieval knights, blood, bizarre and menacing imagery. - The
name should include "Goblin" for one concept. - Guts and Deku were
mentioned as possible references. - They had previously used Lifehunt
Scythe in a Dark Souls 1 run with a blood-themed build and did not want
to repeat that same style. - A Hunter direction was liked, but the build
should remain distinct from the previous blood/scythe character.

### Bloodborne

-   The user wanted an all-rounder build to finish the game after
    completing approximately one-quarter to one-third of it.
-   They asked which starting origin to choose, what to upgrade before
    the Cleric Beast, and where to find the Saw Spear.
-   For similar questions, prioritise an adaptable, reliable PvE build
    rather than assuming advanced endgame knowledge.

## 5. Cooking and food projects

### General cooking

-   The user describes themselves as good at cooking but finds timing
    multiple roast-dinner components difficult. A schedule counting
    backward from the intended serving time is useful.
-   When timing a meal, account for oven temperature, tray space,
    resting time, and items that cook from frozen. Keep the schedule
    realistic if the start time changes.

### Roast chicken dinner (historical plan)

On 30 March 2026, the user planned a roast dinner for around 6:30 pm: -
A medium whole chicken weighing about 1.3 kg, intended to be prepared
spatchcock-style with garlic and herbs. - Cauliflower cheese. - Roast
potatoes. - Frozen Yorkshire puddings. - Carrots and parsnips roasted
together in one roasting dish.

The chicken had been left to defrost overnight but was still rock-solid
at 7:30 am and still mostly frozen at 2:30 pm, when it was placed in
cold water. It later defrosted, but at 6:00 pm had only just gone into
the oven, so the original 6:30 pm meal target was no longer realistic
and a revised schedule was needed. This is historical context, not a
current meal plan. For food safety, avoid suggesting unsafe thawing or
serving undercooked poultry; use a reliable doneness check.

### Jam-making

-   The user was making jam for the first time.
-   They wanted to make cherry-almond jam and considered using amaretto
    to give it an almond flavour.
-   Explain preservation steps clearly for a beginner, including safe
    jar preparation and realistic expectations about flavour and
    setting.

## 6. Makeup and skincare interests

The user wants a **minimal but grungy / soft-grunge / alternative makeup
look** and described themselves as a complete beginner with very little
makeup skill. Explain application in beginner-friendly steps and avoid
assuming they already own tools or products.

### Skin context they shared

-   They were unsure whether their skin was dry or oily.
-   They sweat very easily and thought they might have hyperhidrosis;
    this makes it difficult for them to judge facial shine. Treat this
    as their uncertainty, not as a confirmed diagnosis.
-   At the time, they did not have a face wash and therefore had not
    done a bare-skin test.
-   They usually do not get many spots on the forehead, cheeks, or other
    areas, but do get many blackheads on the nose and chin.
-   They asked about products for sensitive skin.

### Products and questions previously considered

-   CeraVe Hydrating Cleanser versus Foaming Cleanser.
-   CeraVe moisturisers that appeared to be aimed at dry-to-very-dry
    skin.
-   Whether Aveeno Daily Moisturising Body Lotion could be used on the
    face.
-   Byoma SPF 50 Ultralight Face Fluid.
-   L'Oréal tinted serum and shade selection.
-   e.l.f. Hydrating Camo Concealer and shade selection.
-   Translucent powder recommendations.
-   The user specifically asked for light skin tints / BB creams rather
    than a heavier base.

These are historical product questions, not proof that the user bought
or currently uses any of these items. For current product
recommendations, check current availability and ingredients, and be
careful with sensitive-skin claims.

## 7. Growing plants without a garden

-   The user wants to grow plants but does not have a garden.
-   Available space described: one large storage room and windowsills.
-   Future suggestions should focus on indoor growing, container
    gardening, windowsill plants, and making productive use of limited
    space. Ask about light, temperature, ventilation, and whether the
    storage room has a window before recommending plants that need
    strong light.
-   Do not assume the storage room is suitable for plants without
    knowing its lighting conditions.

## 8. Crochet learning

-   The user has asked for help interpreting crochet patterns written in
    US terminology.
-   A pattern included double crochet (dc), chain-2 spaces, slip
    stitches (sl st), chain-3 starts/finishes, and a second colour
    called "Viridescent."
-   They wanted the instructions broken down into clear, step-by-step
    actions.
-   When helping with crochet, preserve the pattern's stitch counts and
    repeat structure, explain US stitch abbreviations, and make it clear
    which stitch or chain space to work into. Do not silently rewrite
    the pattern in UK terminology unless asked.

## 9. Smart devices and local AI

-   The user set up Wire-Pod for an Anki Vector robot and asked for
    custom intents.
-   The user has recently set up a local AI that has limited memory and
    wants to give it a comprehensive memory file. This file is intended
    to help that assistant remember useful context across conversations.
-   For local-AI workflows, it may be useful to separate stable
    preferences, ongoing projects, and dated historical details so stale
    plans are not mistaken for current instructions.
-   Do not assume the user's local model, hardware, inference engine,
    operating system configuration, or memory-file format unless they
    specify it.

## 10. How to help the user effectively

### Preferred response patterns

1.  **For practical tasks:** Give a clear sequence of steps, with
    materials or prerequisites where relevant.
2.  **For scheduling:** Work backward from the target time and include
    realistic buffers.
3.  **For writing:** Offer a polished version that keeps the intended
    meaning, then briefly explain important edits if useful.
4.  **For portfolio work:** Distinguish brainstorming notes from
    professional-facing deliverables.
5.  **For art and pixel art:** Respect the exact dimensions, viewpoint,
    reference shape, setting/era, and requested level of detail.
6.  **For coding and AI prompts:** Make functional requirements
    explicit, distinguish static from dynamic elements, and list failure
    modes to avoid.
7.  **For beginner learning:** Explain the reasoning behind the steps,
    but avoid overwhelming the user with unnecessary theory.
8.  **For product questions:** Treat previously discussed products as
    candidates, not confirmed purchases; check current information when
    needed.
9.  **For continuing projects:** Check this file for constraints before
    proposing a new direction. If a detail may have changed, ask a
    concise question rather than assuming.

### Important distinction: confirmed vs. tentative

-   A question about a product does not mean the user owns it.
-   A proposed project idea does not necessarily mean the user has
    committed to it.
-   A historical schedule is not a current plan.
-   A tentative health-related self-description is not a diagnosis.
-   Some gaming conversations were explicitly from the user's partner;
    do not attribute every preference to the account owner without
    checking.
-   Do not invent missing details or claim to remember an image, file,
    or code that is not actually available.

## 11. Compact quick-reference summary

-   **Creative focus:** Game development, narrative design documents,
    pitch decks, horror concepts, environment art, pixel art, and
    prompts/layouts for other AI tools.
-   **Current business idea:** A Fiverr gig focused on game pitch decks.
-   **Named story concept:** *The Radio Tower* --- a character receives
    phone broadcasts from a local radio tower that has supposedly been
    decommissioned.
-   **Ongoing software/UI concept:** *Custom Spotify Sesh Player* for
    playlist "Smoking Speakers," with fixed custom pixel-art background,
    synced lyrics, and a bottom playback bar.
-   **Art constraints that matter:** Exact pixel dimensions and
    reference-image fidelity; top-down perspective and era must be
    respected.
-   **Gaming:** Project Zomboid, Civilization VI, Dark Souls II,
    Bloodborne. Some Souls-build discussions were from the user's
    partner.
-   **Cooking:** Confident with cooking itself, but appreciates detailed
    multi-dish timing plans.
-   **Food project:** Beginner jam-maker interested in cherry-almond jam
    with amaretto.
-   **Makeup:** Beginner seeking minimal soft-grunge/alternative looks;
    prefers light base products.
-   **Plants:** Wants to grow plants indoors, with a large storage room
    and windowsills but no garden.
-   **Crafts:** Benefits from step-by-step explanations of crochet
    patterns written in US terms.
-   **Devices:** Has set up Wire-Pod for an Anki Vector.
-   **Interaction style:** Practical, collaborative, explicit,
    beginner-friendly where needed, and careful about exact constraints.
