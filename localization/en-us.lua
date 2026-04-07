return {
    descriptions = {
        Joker = {
            j_neonmod_testobjectpleaseignore = {
                name = 'Chair',
                text = {
                    '{C:chips}+#1#{} Chips, {C:mult}#2#{} Mult',
                    '{s=0.5}{C:inactive}A chair ({C:attention}/t͡ʃɛɚ/ 🔊 ⓘ{C:inactive}) is a type of {C:attention}seat{C:inactive}, typically designed for one person and consisting of one{}',
                    '{s=0.5}{C:inactive}or more legs, a flat or slightly angled seat and a back-rest. It may be made of {C:attention}wood{C:inactive}, {C:attention}metal{C:inactive}, or{}',
                    '{s=0.5}{C:inactive}synthetic materials, and may be padded or {C:attention}upholstered{C:inactive} in various colors and fabrics.{}'
                }
            },
            j_neonmod_portalradio = {
                name = 'Portal Radio',
                text = {
                    'Retriggers each played {C:attention}8{}, {C:attention}5{}, and {C:attention}2{} {C:attention}#1#{} additional times',
                    '{s=0.8}{C:inactive,E:1}You\'re listening to the missive of an adequate wordsmith.{}'
                }
            },
            j_neonmod_IDFKMAN = {
                name = 'Testy McTestingson', -- No idea what to name this lol
                text = {
                    'Forces packs in shop to be {C:spectral}Spectral{}',
                    '{C:inactive}(Currently does not work}'
                }
            },
            j_neonmod_joyconl = {
                name = 'JoyCon (L)',
                text = {
                    'This Joker gains {C:chips}+#2#{} Chips when the Joker to the right is triggered',
                    '{C:inactive}(Currently{} {C:chips}+#1#{}{C:inactive} Chips){}'
                }
            },
            j_neonmod_joyconr = {
                name = 'JoyCon (R)',
                text = {
                    'This Joker gains {C:mult}+#2#{} Mult when the Joker to the left is triggered',
                    '{C:green}#3# in #4#{} chance to break at end of round',
                    '{C:inactive}(Currently{} {C:mult}+#1#{}{C:inactive} Mult){}'
                }
            },
            j_neonmod_tcfna = {
                name = 'The Campaign for North Africa: The Desert War 1940-43',
                text = {
                    "Gains {X:mult,C:white} ^#2# {} Mult per card with an {C:enhanced}Enhancement{}, {C:edition}Edition{},",
                    "and {C:spectral}Seal{} in your full deck if at least {C:attention}half{} of the cards in your",
                    "full deck have an {C:enhanced}Enhancement{}, {C:edition}Edition{}, and {C:spectral}Seal{}",
                    "{C:inactive}(Currently {C:attention}#3#{C:inactive} out of {C:attention}#4#{C:inactive})",
                    "{C:inactive}(Currently {X:mult,C:white} ^#1# {}{C:inactive} Mult)",
                },
            },
            j_neonmod_marksman = {
                name = 'Marksman Revolver',
                text = {
                    'Retriggers scored cards {C:attention}#1#{} time',
                    'for every {C:money}$#2#{} you have',
                    '{C:inactive}(Currently {C:attention}#3#{}{C:inactive} retriggers)'
                }
            },
            j_neonmod_marksmancoin = {
                name = 'Marksman Coin',
                text = {
                    'Retriggers the first scoring card {C:attention}#1#{} time',
                    'for every {C:money}$#2#{} you have',
                    'Has a {C:green}#4# in #5#{} chance to break at end of round',
                    '{C:inactive}(Currently {C:attention}#3#{}{C:inactive} retriggers)'
                }
            },
            j_neonmod_hybrid = {
                name = '{C:attention}H{C:gold}Y{C:green}B{C:planet}R{C:common}I{C:spectral}D{}',
                text = {
                    "Gains {X:mult,C:white} X#1# {} Mult at end of Ante for each other Joker",
                    "that {C:attention}did not trigger{} during the Ante",
                    "{C:inactive}(Currently {X:mult,C:white} X#2# {} Mult)",
                    "{s:0.5,C:inactive}{u:inactive,C:blue}DISCLAIMER{}{s:0.5,C:inactive}: {u:inactive,C:blue}WARNING{}{s:0.5,C:inactive}: RULE # 196 is{u:inactive,C:blue}X-rated{}{s:0.5,5:inactive} in that to",
                    "{s:0.5,C:inactive}calculate L, use X = {u:inactive,C:blue}[(C2/10)^2]{}{s:0.5,C:inactive}, which is for",
                    "{s:0.5,C:inactive}mature audience only @ or above age of 20, but most",
                    "{s:0.5,C:inactive}90% of this rpg is for all ages, though maybe NOT",
                    "{s:0.5,C:inactive,u:inactive}RULE # 193{}{s:0.5,C:inactive}which is {u:inactive}NOT{}{s:0.5,C:inactive} meant to be read by kids, and",
                    "{s:0.5,C:inactive,u:inactive}RULE # 187{}{s:0.5,C:inactive}EXPLAINS homosexuality mathematically,",
                    "{s:0.5,C:inactive}using modifier G @ 11.",
                },
            },
            j_neonmod_licensetomaim = {
                name = 'License to Maim',
                text = {
                    'When Boss Blind selected, has a',
                    '{C:green}#2# in #3#{} chance to {C:dark_edition}invert{} its effects'
                }
            },
            j_neonmod_dangeresque = {
                name = 'Dangeresque, Too?',
                text = {
                    'Sell this card during a {C:attention}Boss Blind{}',
                    'for a {C:green}#2# in #3#{} chance to earn {C:money}$#1#{}'
                }
            }
        },
        Blind = {
            bl_neonmod_fleshprison = {
                name = 'The Flesh',
                text = {
                    'Jokers each give',
                    'x0.9 Mult when triggered'
                }
            }
        }
    }
}
