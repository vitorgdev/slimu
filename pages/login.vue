<script setup lang="ts">
import { Button } from "@/components/ui/button";
import {
  Card,
  CardContent,
  CardDescription,
  CardHeader,
  CardTitle,
} from "@/components/ui/card";
import { Input } from "@/components/ui/input";
import { Label } from "@/components/ui/label";
import { createClient } from "@supabase/supabase-js";
import { useToast } from "@/components/ui/toast/use-toast";
import { Toaster } from "@/components/ui/toast";
import { ReloadIcon } from "@radix-icons/vue";

const supabaseUrl = "https://rwdajpktqebludtcvhip.supabase.co";
const supabaseAnonKey =
  "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InJ3ZGFqcGt0cWVibHVkdGN2aGlwIiwicm9sZSI6ImFub24iLCJpYXQiOjE3MTIzODI1NjMsImV4cCI6MjAyNzk1ODU2M30._v5B2j1CORZLbiljRqub5LnWRYHatt6mQkLVQZgBlSs";

const supabase = createClient(supabaseUrl, supabaseAnonKey);
const { toast } = useToast();

const email = ref("");
const password = ref("");
const loading = ref(false);

const handleLogin = async (e: Event) => {
  loading.value = true;
  const { data, error } = await supabase.auth.signInWithPassword({
    email: email.value,
    password: password.value,
  });
  if (error) {
    toast({
      title: "Alguma coisa deu errado.",
      description: "Login ou senha invalidos.",
      duration: 3000,
      variant: "destructive",
    });
  } else {
    window.localStorage.setItem(
      "supabase.auth.token",
      data.session?.access_token || ""
    );
    toast({
      title: "Sucesso!",
      description: "Login efetuado com sucesso.",
      duration: 3000,
      variant: "default",
    });
    navigateTo("/home");
  }
  loading.value = false;
};

const handleGoogleLogin = async (e: Event) => {
  const { error, data } = await supabase.auth.signInWithOAuth({
    provider: "google",
  });
  console.log(data, error);
  if (error) {
    toast({
      title: "Alguma coisa deu errado.",
      description: "Login ou senha invalidos.",
      duration: 3000,
      variant: "destructive",
    });
  } else {
    // window.localStorage.setItem(
    //   "supabase.auth.token",
    //   data.provider || ""
    // );
    navigateTo("/home");
    toast({
      title: "Sucesso!",
      description: "Login efetuado com sucesso.",
      duration: 3000,
      variant: "default",
    });
  }
};
</script>

<template>
  <div class="flex h-screen items-center justify-center">
    <Toaster />
    <Card class="mx-auto max-w-sm">
      <CardHeader>
        <CardTitle class="text-2xl"> Login </CardTitle>
        <CardDescription>
          Enter your email below to login to your account
        </CardDescription>
      </CardHeader>
      <CardContent>
        <div class="grid gap-4">
          <div class="grid gap-2">
            <Label for="email">Email</Label>
            <Input
              id="email"
              type="email"
              placeholder="m@example.com"
              required
              v-model="email"
            />
          </div>
          <div class="grid gap-2">
            <div class="flex items-center">
              <Label for="password">Password</Label>
              <a href="#" class="ml-auto inline-block text-sm underline">
                Forgot your password?
              </a>
            </div>
            <Input id="password" type="password" required v-model="password" />
          </div>
          <Button
            :disabled="loading"
            type="submit"
            class="w-full"
            @click="handleLogin"
          >
            <span v-if="!loading">Login</span>
            <span v-else>
              <ReloadIcon class="w-4 h-4 mr-2 animate-spin" />
              Please wait
            </span>
          </Button>
          <Button variant="outline" class="w-full" @click="handleGoogleLogin">
            Login with Google
          </Button>
        </div>
        <div class="mt-4 text-center text-sm">
          Don't have an account?
          <a href="#" class="underline"> Sign up </a>
        </div>
      </CardContent>
    </Card>
  </div>
</template>
