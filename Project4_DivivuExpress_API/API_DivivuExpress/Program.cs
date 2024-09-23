using BussinessLayer;
using BussinessLayer.Interfaces;
using DataAccessLayer;
using DataAccessLayer.Interfaces;

var builder = WebApplication.CreateBuilder(args);

// Add services to the container.
builder.Services.AddTransient<IDatabaseHelper, DatabaseHelper>();
builder.Services.AddTransient<I_taiKhoanResponsitory, taiKhoanResponsitory>();
builder.Services.AddTransient<I_taiKhoanBUS, taiKhoanBUS>();
//builder.Services.AddTransient<IHoaDonRepository, HoaDonRepository>();
//builder.Services.AddTransient<IHoaDonBusiness, HoaDonBusiness>();
builder.Services.AddControllers();



// Learn more about configuring Swagger/OpenAPI at https://aka.ms/aspnetcore/swashbuckle
builder.Services.AddEndpointsApiExplorer();
builder.Services.AddSwaggerGen();

var app = builder.Build();

// Configure the HTTP request pipeline.
if (app.Environment.IsDevelopment())
{
    app.UseSwagger();
    app.UseSwaggerUI();
}

app.UseHttpsRedirection();

app.UseAuthorization();

app.MapControllers();

app.Run();
