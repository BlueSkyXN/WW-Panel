<template>
  <v-container>
    <h1 class="text-center mb-6">攻击x暴击x元素伤害的基值计算器</h1>

    <v-card v-for="(group, groupIndex) in parameterGroups" :key="groupIndex" class="mb-6">
      <v-card-title>{{ group.title }}</v-card-title>
      <v-card-text>
        <v-row>
          <v-col cols="12" sm="4" md="2" v-for="(field, fieldIndex) in group.fields" :key="fieldIndex">
            <v-text-field
              :label="field.label"
              v-model.number="field.value"
              type="number"
              :step="field.step"
              outlined
              dense
            ></v-text-field>
          </v-col>
        </v-row>
      </v-card-text>
    </v-card>

    <v-card class="mt-6">
      <v-card-title>计算结果</v-card-title>
      <v-card-text>
        <v-row>
          <v-col cols="12" sm="4" md="2" v-for="(result, index) in calculatedResults" :key="index">
            <v-sheet rounded elevation="1" class="pa-4">
              <div class="text-subtitle-2">{{ result.label }}</div>
              <div class="text-h6">{{ result.value.toFixed(3) }}</div>
            </v-sheet>
          </v-col>
        </v-row>
      </v-card-text>
    </v-card>
  </v-container>
</template>

<script>
export default {
  name: 'GameCalculator',
  data() {
    return {
      parameterGroups: [
        {
          title: '基本信息',
          fields: [
            { label: '初始暴击率', value: 0.05, step: 0.01 },
            { label: '初始暴击伤害', value: 1.50, step: 0.01 },
            { label: '角色攻击白值', value: 462, step: 1 },
            { label: '武器攻击白值', value: 587, step: 1 }
          ]
        },
        {
          title: '天赋',
          fields: [
            { label: '天赋暴击率', value: 0.08, step: 0.01 },
            { label: '天赋暴击伤害', value: 0.00, step: 0.01 },
            { label: '天赋攻击百分比', value: 0.12, step: 0.01 },
            { label: '天赋元素伤害百分比', value: 0.00, step: 0.01 }
          ]
        },
        {
          title: '武器',
          fields: [
            { label: '武器暴击率', value: 0.00, step: 0.01 },
            { label: '武器暴击伤害', value: 0.484, step: 0.01 },
            { label: '武器攻击百分比', value: 0.24, step: 0.01 },
            { label: '武器元素伤害百分比', value: 0.00, step: 0.01 }
          ]
        },
        {
          title: '声骸',
          fields: [
            { label: '声骸暴击率', value: 0.411, step: 0.01 },
            { label: '声骸暴击伤害', value: 1.136, step: 0.01 },
            { label: '声骸攻击百分比', value: 0.69, step: 0.01 },
            { label: '声骸攻击固定值', value: 390, step: 1 },
            { label: '声骸元素伤害百分比', value: 0.60, step: 0.01 }
          ]
        },
        {
          title: '其他',
          fields: [
            { label: '其他暴击率', value: 0.25, step: 0.01 },
            { label: '其他暴击伤害', value: 0.00, step: 0.01 },
            { label: '其他攻击百分比', value: 0.35, step: 0.01 },
            { label: '其他攻击固定值', value: 0.00, step: 1 },
            { label: '其他元素伤害百分比', value: 0.10, step: 0.01 }
          ]
        }
      ]
    };
  },
  computed: {
    finalCritRate() {
      return this.sumFieldValues('暴击率');
    },
    finalCritDamage() {
      return this.sumFieldValues('暴击伤害');
    },
    finalAttackPercent() {
      return this.sumFieldValues('攻击百分比');
    },
    finalAttackFixed() {
      return this.sumFieldValues('攻击固定值');
    },
    finalElementDamagePercent() {
      return this.sumFieldValues('元素伤害百分比');
    },
    finalActualAttack() {
      const baseAttack = this.getFieldValue('角色攻击白值') + this.getFieldValue('武器攻击白值');
      return baseAttack * (1 + this.finalAttackPercent) + this.finalAttackFixed;
    },
    finalDamageBase() {
      const actualAttack = this.finalActualAttack;
      return (
        (actualAttack * this.finalCritRate * this.finalCritDamage + actualAttack * (1 - this.finalCritRate)) * (1 + this.finalElementDamagePercent)
      );
    },
    calculatedResults() {
      return [
        { label: '最终暴击率', value: this.finalCritRate },
        { label: '最终暴击伤害', value: this.finalCritDamage },
        { label: '最终攻击百分比', value: this.finalAttackPercent },
        { label: '最终攻击固定值', value: this.finalAttackFixed },
        { label: '最终元素伤害百分比', value: this.finalElementDamagePercent },
        { label: '最终实际攻击', value: this.finalActualAttack },
        { label: '最终实际伤害基值', value: this.finalDamageBase }
      ];
    }
  },
  methods: {
    sumFieldValues(fieldName) {
      return this.parameterGroups.reduce((sum, group) => {
        const fields = group.fields.filter(f => f.label.includes(fieldName));
        return sum + fields.reduce((fieldSum, field) => fieldSum + field.value, 0);
      }, 0);
    },
    getFieldValue(fieldName) {
      for (const group of this.parameterGroups) {
        const field = group.fields.find(f => f.label === fieldName);
        if (field) return field.value;
      }
      return 0;
    }
  }
};
</script>

<style scoped>
.v-sheet {
  transition: all 0.3s;
}
.v-sheet:hover {
  transform: translateY(-5px);
  box-shadow: 0 5px 15px rgba(0,0,0,0.1);
}
</style>