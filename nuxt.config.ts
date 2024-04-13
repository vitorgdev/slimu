export default defineNuxtConfig({
  modules: ["@nuxtjs/tailwindcss", "shadcn-nuxt"],
  runtimeConfig: {
    public: {
      supabaseUrl: process.env.VUE_APP_SUPABASE_URL,
      supabaseKey: process.env.VUE_APP_SUPABASE_ANON_KEY,
    },
  },
  shadcn: {
    /**
     * Prefix for all the imported component
     */
    prefix: "",
    /**
     * Directory that the component lives in.
     * @default "./components/ui"
     */
    componentDir: "./components/ui",
  },
});
