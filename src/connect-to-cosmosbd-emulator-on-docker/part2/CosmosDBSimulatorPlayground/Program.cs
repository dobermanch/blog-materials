using Microsoft.EntityFrameworkCore;
using Microsoft.Extensions.DependencyInjection;

var context = 
    new ServiceCollection()
        .AddCosmos<CosmosDbContext>(
            connectionString: "AccountEndpoint=https://localhost:8081/;AccountKey=C2y6yDjf5/R+ob0N8A7Cgv30VRDJIWEHLM+4QDU5DE2nQ9nDuVTqobD4b8mGGyPMbIZnqyMsEcaGQy67XIw/Jw==",
            databaseName: "CosmosDb")
        .BuildServiceProvider()
        .GetRequiredService<CosmosDbContext>();

await context.Database.EnsureCreatedAsync();

context.Entity.Add(new Entity(Guid.NewGuid().ToString()));
await context.SaveChangesAsync();

class CosmosDbContext : DbContext
{
    public CosmosDbContext(DbContextOptions<CosmosDbContext> options) 
        : base(options) { }

    public DbSet<Entity> Entity { get; set; } = null!;
}

public record Entity(string Id);