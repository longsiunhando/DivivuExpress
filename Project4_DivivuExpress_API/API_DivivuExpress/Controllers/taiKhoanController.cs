using BussinessLayer.Interfaces;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using Model;

namespace API_DivivuExpress.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class taiKhoanController : ControllerBase
    {
        private I_taiKhoanBUS _TaiKhoanBUS;
        public taiKhoanController(I_taiKhoanBUS taiKhoanBUS)
        {
            _TaiKhoanBUS = taiKhoanBUS;
        }

        [Route("get-all-taiKhoan")]
        [HttpGet]
        public List<taiKhoanModel> GetAllTaiKhoan()
        {
            return _TaiKhoanBUS.GetAllTaiKhoanModels();
        }


        [Route("get-taiKhoan-by-str")]
        [HttpGet]
        public List<taiKhoanModel> GetTaiKhoan(string str)
        {
            return _TaiKhoanBUS.GetTaiKhoanModels(str);
        }

    }
}
