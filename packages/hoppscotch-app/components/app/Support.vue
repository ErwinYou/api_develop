<template>
  <SmartModal
    v-if="show"
    :title="t('support.title')"
    max-width="sm:max-w-md"
    @close="$emit('hide-modal')"
  >
    <template #body>
      <div class="flex flex-col space-y-2">
        <SmartItem
          svg="book"
          :label="t('app.documentation')"
          to="https://docs.hoppscotch.io"
          :description="t('support.documentation')"
          info-icon="chevron_right"
          active
          blank
          @click.native="hideModal()"
        />
        <SmartItem
          svg="zap"
          :label="t('app.keyboard_shortcuts')"
          :description="t('support.shortcuts')"
          info-icon="chevron_right"
          active
          @click.native="showShortcuts()"
        />
      </div>
    </template>
  </SmartModal>
</template>

<script setup lang="ts">
import { invokeAction } from "~/helpers/actions"
import { useI18n } from "~/helpers/utils/composables"

const t = useI18n()

defineProps<{
  show: Boolean
}>()

const emit = defineEmits<{
  (e: "hide-modal"): void
}>()

const showShortcuts = () => {
  invokeAction("flyouts.keybinds.toggle")
  hideModal()
}

const hideModal = () => {
  emit("hide-modal")
}
</script>
