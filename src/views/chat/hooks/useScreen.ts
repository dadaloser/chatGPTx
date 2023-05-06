import { ref } from 'vue'

export function useScreenContext() {
  const isFullscreen = ref(false)

  function toggleFullScreen() {
    if (!isFullscreen.value)
      document.documentElement.requestFullscreen()
    else
      document.exitFullscreen()

    isFullscreen.value = !isFullscreen.value
  }

  return {
    isFullscreen,
    toggleFullScreen,
  }
}
