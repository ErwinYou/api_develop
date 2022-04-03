<template>
  <SmartModal
    v-if="show"
    :title="t('app.invite_your_friends')"
    @close="hideModal"
  >
    <template #body>
      <p class="px-2 mb-8 text-secondaryLight">
        {{ t("app.invite_description") }}
      </p>
      <div class="flex flex-col px-2 space-y-2">
        <div class="grid grid-cols-3 gap-4">
          <a
            v-for="(platform, index) in platforms"
            :key="`platform-${index}`"
            :href="platform.link"
            target="_blank"
            class="share-link"
          >
            <SmartIcon :name="platform.icon" class="w-6 h-6" />
            <span class="mt-3">
              {{ platform.name }}
            </span>
          </a>
          <button class="share-link" @click="copyAppLink">
            <SmartIcon class="w-6 h-6 text-xl" :name="copyIcon" />
            <span class="mt-3">
              {{ t("app.copy") }}
            </span>
          </button>
        </div>
      </div>
    </template>
  </SmartModal>
</template>

<script setup lang="ts">
import { ref } from "@nuxtjs/composition-api"
import { copyToClipboard } from "~/helpers/utils/clipboard"
import { useI18n, useToast } from "~/helpers/utils/composables"

const t = useI18n()

const toast = useToast()

defineProps<{
  show: Boolean
}>()

const emit = defineEmits<{
  (e: "hide-modal"): void
}>()

const url = "https://hoppscotch.io"
const subject = "Checkout Hoppscotch - an open source API development ecosystem"
const summary = `Hi there!%0D%0A%0D%0AI thought you'll like this new platform that I joined called Hoppscotch - https://hoppscotch.io.%0D%0AIt is a simple and intuitive interface for creating and managing your APIs. You can build, test, document, and share your APIs.%0D%0A%0D%0AThe best part about Hoppscotch is that it is open source and free to get started.%0D%0A%0D%0A`

const copyIcon = ref("copy")
const platforms = [
  {
    name: "Email",
    icon: "mail",
    link: `mailto:?subject=${subject}&body=${summary}`,
  },
]

const copyAppLink = () => {
  copyToClipboard(url)
  copyIcon.value = "check"
  toast.success(`${t("state.copied_to_clipboard")}`)
  setTimeout(() => (copyIcon.value = "copy"), 1000)
}

const hideModal = () => {
  emit("hide-modal")
}
</script>

<style lang="scss" scoped>
.share-link {
  @apply border border-dividerLight;
  @apply rounded;
  @apply flex-col flex;
  @apply p-4;
  @apply items-center;
  @apply justify-center;
  @apply font-semibold;
  @apply hover:(bg-primaryLight text-secondaryDark);
  @apply focus:outline-none;
  @apply focus-visible:border-divider;

  svg {
    @apply opacity-80;
  }

  &:hover {
    svg {
      @apply opacity-100;
    }
  }
}
</style>
