<script setup lang="ts">
import {
  Table,
  TableBody,
  TableCaption,
  TableCell,
  TableHead,
  TableHeader,
  TableRow,
} from "@/components/ui/table";

const invoices = [
  {
    invoice: "INV001",
    paymentStatus: "Paid",
    totalAmount: "$250.00",
    paymentMethod: "Credit Card",
  },
  {
    invoice: "INV002",
    paymentStatus: "Pending",
    totalAmount: "$150.00",
    paymentMethod: "PayPal",
  },
  {
    invoice: "INV003",
    paymentStatus: "Unpaid",
    totalAmount: "$350.00",
    paymentMethod: "Bank Transfer",
  },
  {
    invoice: "INV004",
    paymentStatus: "Paid",
    totalAmount: "$450.00",
    paymentMethod: "Credit Card",
  },
  {
    invoice: "INV005",
    paymentStatus: "Paid",
    totalAmount: "$550.00",
    paymentMethod: "PayPal",
  },
  {
    invoice: "INV006",
    paymentStatus: "Pending",
    totalAmount: "$200.00",
    paymentMethod: "Bank Transfer",
  },
  {
    invoice: "INV007",
    paymentStatus: "Unpaid",
    totalAmount: "$300.00",
    paymentMethod: "Credit Card",
  },
];
</script>

<template>
  <div class="grid gap-4 lg:grid-cols-3 lg:gap-8">
    <div class="lg:col-span-3">
      <Card>
        <CardHeader>
          <CardTitle>Detalhes de Usuários</CardTitle>
          <CardDescription>
            Listagem de todos os usuários ativos
          </CardDescription>
        </CardHeader>
        <CardContent>
          <div class="grid gap-6">
            <Table>
              <TableCaption>Uma lista com todos os usuários.</TableCaption>
              <TableHeader>
                <TableRow>
                  <TableHead class="w-[100px]">Nome</TableHead>
                  <TableHead>Cargo</TableHead>
                  <TableHead>Data de contratação</TableHead>
                  <TableHead class="text-right">Status</TableHead>
                  <TableHead class="text-right">&nbsp;</TableHead>
                </TableRow>
              </TableHeader>
              <TableBody>
                <TableRow v-for="invoice in invoices" :key="invoice.invoice">
                  <TableCell class="font-medium">
                    {{ invoice.invoice }}
                  </TableCell>
                  <TableCell>{{ invoice.paymentStatus }}</TableCell>
                  <TableCell>{{ invoice.paymentMethod }}</TableCell>
                  <TableCell class="text-right">
                    {{ invoice.totalAmount }}
                  </TableCell>

                  <TableCell class="text-right">
                    <Button size="sm" variant="outline">Expandir</Button>
                    <Button class="ml-2 text-red-500" variant="outline"
                      >Excluir</Button
                    >
                  </TableCell>
                </TableRow>
              </TableBody>
            </Table>
          </div>
        </CardContent>
      </Card>
    </div>
  </div>
</template>
