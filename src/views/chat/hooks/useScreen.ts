import { computed } from 'vue'
import { useAppStore } from '@/store'

export function useScreenContext() {
  const appStore = useAppStore()
  const isFullscreen = computed<boolean>(() => appStore.fullscreen)

  function toggleFullScreen() {
    if (!isFullscreen.value) {
      document.documentElement.requestFullscreen().then((r) => {
      })
    }
    else {
      document.exitFullscreen().then((r) => {
      })
    }

    appStore.setFullscreen(!isFullscreen.value)
  }

  return {
    isFullscreen,
    toggleFullScreen,
  }
}
