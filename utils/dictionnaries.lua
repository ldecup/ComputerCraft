local ENERGY_STORE = {
    -- Mekanism
    "basicEnergyCube",
    "advancedEnergyCube",
    "eliteEnergyCube",
    "ultimateEnergyCube",
    "inductionPort", -- For the induction matrix
}

local ENERGY_PROD = {
    -- Bigger Reactors
    "BiggerReactors_Reactor"
}

local ENERGY_DATA = {
    type = "",  -- PROD or STORE
    unit = "",  -- Unit of energy, FE or RF or J
    loc = {0, 0, 0},

    -- Storage values
    currentEnergy = nil,
    capacity = nil,
    currentEnergyPercent = nil,
    transferCap = nil,  -- Output, input or production

    -- PROD values
    fuelTankCap = nil,
    fuelTankStored = nil,
    fuelTankFillPer = nil,
    coolTankCap = nil,
    coolTankStored = nil,
    coolTankFillPer = nil,
    casingTemp = nil,
    fuelTemp = nil,

    -- PROD statuses
    active = nil,
    controlRods = {},
}

return {ENERGY_STORE = ENERGY_STORE, ENERGY_PROD = ENERGY_PROD, ENERGY_DATA = ENERGY_DATA}