lol.itemEffects = (->
  makeEffect = (name, params) ->
    params.name = name
    params.unique = yes
    return params

  aid: ->
    makeEffect "Aid",
      desc: "Your Summoner Heal, Revive, and Clairvoyance cooldowns are reduced by 20%."

  avarice: ->
    makeEffect "Avarice",
      desc: "Gain +2 additional gold every 10 seconds."
      applyToStats: (stats) -> gp10: 2

  awe: ->
    makeEffect "Awe",
      desc: "Gain attack damage equal to 2% of your maximum mana."
      applyToStats: (stats) -> ad: mana * 0.02

  cleave: ->
    makeEffect "Cleave",
      meleeOnly: yes
      desc: "Your attacks deal physical damage up to 60% of your Attack Damage to units around your target, decaying down to 20% near the edge."

  coldSteel: (as, ms, dur) ->
    makeEffect "Cold Steel",
      desc: "If you are hit by a basic attack, you slow the attacker's attack speed by #{as}% #{if ms then "and their movement speed by 10% " else ""}for #{dur} seconds."

  crescent: ->
    makeEffect "Crescent",
      meleeOnly: yes
      cd: 10
      desc: "Deals physical damage up to 100% of your Attack Damage to units around you, decaying down to 60% near the edge."

  eleisasBlessing: ->
    makeEffect "Eleisa's Blessing",
      desc: "If you gain 3 levels with this item, you gain all the effects permanently and this item is consumed."

  enhancedMovement: (speed) ->
    makeEffect "Enhanced Movement",
      desc: "+#{speed} movement speed"
      applyToStats: (stats) -> ms: speed

  eyesOfPain: ->
    makeEffect "Eyes of Pain",
      desc: "+15 magic penetration"
      applyToStats: (stats) -> mPen: 15

  greed: ->
    makeEffect "Greed",
      desc: "Gain an additional 2 gold every kill."

  icy: (chance, amt, duration, ranged) ->
    desc = ""
    if chance is ranged
      desc = "#{chance}% chance on hit to reduce your target's movement speed by #{amt}% for #{duration} seconds."
    else if chance is 100
      desc = "Your basic attacks slow your target's Movement Speed by #{amt}% for #{duration} seconds (#{ranged}% slow for ranged attacks)."
    else
      desc = "Your basic attacks have a #{chance}% chance to slow your target's Movement Speed by #{amt}% for #{duration} seconds (#{ranged}% slow for ranged attacks)."

    makeEffect "Icy"
      desc: desc

  legion: ->
    makeEffect "Legion",
      range: 1200
      desc: "Nearby allied champions gain +10 armor, +15 magic resist, and +10 health regen per 5 seconds."
      applyToStats: (stats) ->
        armor: 10
        mr: 15
        hp5: 10

  lifeline: (strength) ->
    makeEffect "Lifeline"
      desc: "If you would take magic damage which would leave you at less than 30% of your maximum health, you gain a shield which absorbs up to #{strength} magic damage for 5 seconds. 60 second cooldown."

  luckyShadow: ->
    makeEffect "Lucky Shadow",
      desc: "Gain +4 additional gold every 10 seconds."
      applyToStats: (stats) -> gp10: 4

  maim: (chance, amt) ->
    makeEffect "Maim",
      desc: "Your basic attacks against minions and monsters have a #{chance}% chance to deal #{amt} bonus magic damage."

  manaCharge: (attack, bonus) ->
    makeEffect "Mana Charge",
      desc: "Each time you #{if attack then "attack, " else ""} cast a spell or spend mana, your maximum mana increases by #{bonus} (3 second cooldown). Bonus caps at +750 bonus mana."

  manaFont: ->
    makeEffect "Mana Font",
      desc: "Increases your mana regeneration by 1% per 1% mana you are missing."

  manaWarp: ->
    makeEffect "Mana Warp",
      range: 1100
      desc: "Nearby allied champions gain 6 mana regen per 5 seconds."
      applyToStats: (stats) -> mp5: 6

  promote: ->
    makeEffect "Promote",
      cd: 180
      desc: "Transforms a nearby siege minion to a more powerful unit. You gain all the gold this unit earns."

  quicksilver: (speed) ->
    makeEffect "Quicksilver",
      cd: 90
      desc: "Removes all debuffs from your champion. #{if speed then "Melee champions also gain +50% movement speed for 1 second. " else ""}"

  rend: ->
    makeEffect "Rend",
      desc: "Basic attacks deal 10 bonus true damage to monsters."

  slowResist: ->
    makeEffect "Slow Resist",
      desc: "Movement slowing effects are reduced by 25%."

  spellblade: (desc) ->
    makeEffect "Spellblade",
      desc: desc

  tenacity: ->
    makeEffect "Tenacity",
      desc: "The duration of stuns, slows, taunts, fears, silences, blinds and immobilizes are reduced by 35%."

  transmute: ->
    makeEffect "Transmute",
      desc: "Gain +5 additional gold every 10 seconds."
      applyToStats: (stats) -> gp10: 5

  valor: (amt, extra) ->
    makeEffect "Valor",
      desc: (->
        msg = ""
        if extra
          msg = "Nearby allies gain +#{amt} health regen and nearby allied minions deal 15% increased damage."
        else
          msg = "Nearby allied champions gain +#{amt} health regen per 5 seconds."
        return msg
        )()
      applyToStats: (stats) -> hp5: amt

  valorsReward: ->
    makeEffect "Valor's Reward",
      desc: "On leveling up, restores 150 health and 200 mana over 8 seconds."
)()
