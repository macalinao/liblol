itemEffects = (->
  makeEffect = (name, params) ->
    params.name = name
    params.unique = yes
    params.desc = name + ": " + params
    return params

  aid: ->
    makeEffect "Aid",
      desc: "Your Summoner Heal, Revive, and Clairvoyance cooldowns are reduced by 20%."

  avarice: ->
    makeEffect "Avarice",
      desc: "Gain +2 additional gold every 10 seconds."
      applyToStats: (stats) -> gp10: 2

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

  slowResist: ->
    makeEffect "Slow Resist",
      desc: "Movement slowing effects are reduced by 25%."

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
