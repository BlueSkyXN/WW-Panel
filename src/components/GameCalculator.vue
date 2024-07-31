<template>
  <v-container>
    <h2>攻击x暴击x元素伤害的基值计算器</h2>
    <v-divider></v-divider>
    
    <h3>基本信息</h3>
    <v-row>
      <v-col cols="12" sm="6" md="4" lg="2" v-for="field in basicInfo" :key="field.model">
        <v-text-field
          :label="field.label"
          :type="field.type"
          :step="field.step"
          v-model.number="field.value"
        ></v-text-field>
      </v-col>
    </v-row>
    
    <v-divider></v-divider>
    
    <h3>天赋</h3>
    <v-row>
      <v-col cols="12" sm="6" md="4" lg="2" v-for="field in talents" :key="field.model">
        <v-text-field
          :label="field.label"
          :type="field.type"
          :step="field.step"
          v-model.number="field.value"
        ></v-text-field>
      </v-col>
    </v-row>
    
    <v-divider></v-divider>
    
    <h3>武器</h3>
    <v-row>
      <v-col cols="12" sm="6" md="4" lg="2" v-for="field in weapons" :key="field.model">
        <v-text-field
          :label="field.label"
          :type="field.type"
          :step="field.step"
          v-model.number="field.value"
        ></v-text-field>
      </v-col>
    </v-row>
    
    <v-divider></v-divider>
    
    <h3>声骸</h3>
    <v-row>
      <v-col cols="12" sm="6" md="4" lg="2" v-for="field in relics" :key="field.model">
        <v-text-field
          :label="field.label"
          :type="field.type"
          :step="field.step"
          v-model.number="field.value"
        ></v-text-field>
      </v-col>
    </v-row>
    
    <v-divider></v-divider>
    
    <h3>其他</h3>
    <v-row>
      <v-col cols="12" sm="6" md="4" lg="2" v-for="field in others" :key="field.model">
        <v-text-field
          :label="field.label"
          :type="field.type"
          :step="field.step"
          v-model.number="field.value"
        ></v-text-field>
      </v-col>
    </v-row>
    
    <v-divider></v-divider>

    <!-- 计算结果展示部分 -->
    <v-row>
      <v-col cols="12" md="6">
        <v-card>
          <v-card-title>计算结果</v-card-title>
          <v-card-text>
            <p>最终暴击率: {{ finalCritRate.toFixed(3) }}</p>
            <p>最终暴击伤害: {{ finalCritDamage.toFixed(3) }}</p>
            <p>最终攻击百分比: {{ finalAttackPercent.toFixed(3) }}</p>
            <p>最终攻击固定值: {{ finalAttackFixed }}</p>
            <p>最终元素伤害百分比: {{ finalElementDamagePercent.toFixed(3) }}</p>
          </v-card-text>
        </v-card>
      </v-col>

      <v-col cols="12" md="1">
        <v-divider vertical></v-divider>
      </v-col>

      <v-col cols="12" md="5">
        <v-card>
          <v-card-title>计算结果</v-card-title>
          <v-card-text>
            <p>最终实际攻击: {{ finalActualAttack.toFixed(3) }}</p>
            <p>最终实际伤害基值: {{ finalDamageBase.toFixed(3) }}</p>
          </v-card-text>
        </v-card>
      </v-col>
    </v-row>
  </v-container>
</template>

<script>
export default {
  name: 'GameCalculator',
  data() {
    return {
      basicInfo: [
        { label: '初始暴击率', model: 'baseCritRate', value: 0.05, type: 'number', step: 0.01 },
        { label: '初始暴击伤害', model: 'baseCritDamage', value: 1.50, type: 'number', step: 0.01 },
        { label: '角色攻击白值', model: 'baseAttack', value: 462, type: 'number', step: 1 },
        { label: '武器攻击白值', model: 'weaponAttack', value: 587, type: 'number', step: 1 }
      ],
      talents: [
        { label: '天赋暴击率', model: 'talentCritRate', value: 0.08, type: 'number', step: 0.01 },
        { label: '天赋暴击伤害', model: 'talentCritDamage', value: 0.00, type: 'number', step: 0.01 },
        { label: '天赋攻击百分比', model: 'talentAttackPercent', value: 0.12, type: 'number', step: 0.01 },
        { label: '天赋元素伤害百分比', model: 'talentElementDamagePercent', value: 0.00, type: 'number', step: 0.01 }
      ],
      weapons: [
        { label: '武器暴击率', model: 'weaponCritRate', value: 0.00, type: 'number', step: 0.01 },
        { label: '武器暴击伤害', model: 'weaponCritDamage', value: 0.484, type: 'number', step: 0.01 },
        { label: '武器攻击百分比', model: 'weaponAttackPercent', value: 0.24, type: 'number', step: 0.01 },
        { label: '武器元素伤害百分比', model: 'weaponElementDamagePercent', value: 0.00, type: 'number', step: 0.01 }
      ],
      relics: [
        { label: '声骸暴击率', model: 'relicCritRate', value: 0.411, type: 'number', step: 0.01 },
        { label: '声骸暴击伤害', model: 'relicCritDamage', value: 1.136, type: 'number', step: 0.01 },
        { label: '声骸攻击百分比', model: 'relicAttackPercent', value: 0.69, type: 'number', step: 0.01 },
        { label: '声骸攻击固定值', model: 'relicAttackFixed', value: 390, type: 'number', step: 1 },
        { label: '声骸元素伤害百分比', model: 'relicElementDamagePercent', value: 0.60, type: 'number', step: 0.01 }
      ],
      others: [
        { label: '其他暴击率', model: 'extraCritRate', value: 0.25, type: 'number', step: 0.01 },
        { label: '其他暴击伤害', model: 'extraCritDamage', value: 0.00, type: 'number', step: 0.01 },
        { label: '其他攻击百分比', model: 'extraAttackPercent', value: 0.35, type: 'number', step: 0.01 },
        { label: '其他攻击固定值', model: 'extraAttackFixed', value: 0.00, type: 'number', step: 1 },
        { label: '其他元素伤害百分比', model: 'extraElementDamagePercent', value: 0.10, type: 'number', step: 0.01 }
      ]
    };
  },
  computed: {
    finalCritRate() {
      return (
        this.basicInfo[0].value + 
        this.talents[0].value + 
        this.weapons[0].value + 
        this.relics[0].value + 
        this.others[0].value
      );
    },
    finalCritDamage() {
      return (
        this.basicInfo[1].value + 
        this.talents[1].value + 
        this.weapons[1].value + 
        this.relics[1].value + 
        this.others[1].value
      );
    },
    finalAttackPercent() {
      return (
        this.talents[2].value + 
        this.weapons[2].value + 
        this.relics[2].value + 
        this.others[2].value
      );
    },
    finalAttackFixed() {
      return this.relics[3].value + this.others[3].value;
    },
    finalElementDamagePercent() {
      return (
        this.talents[3].value + 
        this.weapons[3].value + 
        this.relics[4].value + 
        this.others[4].value
      );
    },
    finalActualAttack() {
      const baseAttack = this.basicInfo[2].value + this.basicInfo[3].value;
      return baseAttack * (1 + this.finalAttackPercent) + this.finalAttackFixed;
    },
    finalDamageBase() {
      const actualAttack = this.finalActualAttack;
      return (
        (actualAttack * this.finalCritRate * this.finalCritDamage + actualAttack * (1 - this.finalCritRate)) * (1 + this.finalElementDamagePercent)
      );
    }
  }
}
</script>

<style>
.v-container {
  max-width: 1000px;
  margin: 0 auto;
}

.v-row {
  flex-wrap: wrap;
}

.v-col {
  padding: 8px;
}

.v-divider.vertical {
  height: 100%;
  margin: 0;
}
</style>
