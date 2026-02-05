using NicaraguaTourism.Entities.Dtos;
using NicaraguaTourism.Entities.Models;
using Riok.Mapperly.Abstractions;

namespace NicaraguaTourism.Bll.Mappings
{
    [Mapper]
    public partial class TourismMapper
    {
        [MapperIgnoreTarget(nameof(User.UserId))]
        [MapperIgnoreTarget(nameof(User.CreatedAt))]
        public partial User UserRegisterDtoToUser(UserRegisterDto dto);
        
        [MapperIgnoreTarget(nameof(User.Password))]
        [MapperIgnoreTarget(nameof(User.CreatedAt))]
        public partial User UserUpdateToDto(UserUpdateDto dto);

        [MapperIgnoreTarget(nameof(UserDto.RoleName))]
        [MapperIgnoreSource(nameof(User.Password))]
        public partial UserDto UserToUserDto(User user);

        [MapperIgnoreTarget(nameof(Destination.DestinationId))]
        [MapperIgnoreTarget(nameof(Destination.AdminId))]
        [MapperIgnoreTarget(nameof(Destination.CreatedAt))]
        [MapperIgnoreSource(nameof(DestinationRegisterDto.Images))]
        [MapperIgnoreSource(nameof(DestinationRegisterDto.Activities))]
        public partial Destination DestinationRegisterDtoToDestination(DestinationRegisterDto dto);

        [MapperIgnoreTarget(nameof(Destination.AdminId))]
        [MapperIgnoreTarget(nameof(Destination.CreatedAt))]
        [MapperIgnoreSource(nameof(DestinationUpdateDto.Images))]
        [MapperIgnoreSource(nameof(DestinationUpdateDto.Activities))]
        public partial Destination DestinationUpdateToDto(DestinationUpdateDto dto);

        [MapperIgnoreSource(nameof(Destination.AdminId))]
        [MapperIgnoreSource(nameof(Destination.CreatedAt))]
        [MapperIgnoreTarget(nameof(DestinationDto.Images))]
        [MapperIgnoreTarget(nameof(DestinationDto.Activities))]
        public partial DestinationDto DestinationToDestinationDto(Destination destination);

        [MapperIgnoreTarget(nameof(DestinationImage.ImageId))]
        [MapperIgnoreTarget(nameof(DestinationImage.DestinationId))]
        [MapperIgnoreTarget(nameof(DestinationImage.AdminId))]
        [MapperIgnoreTarget(nameof(DestinationImage.UploadedAt))]
        public partial DestinationImage DestinationImageInsertDtoToDestinationImage(DestinationImageInsertDto dto);

        [MapperIgnoreSource(nameof(DestinationImage.ImageId))]
        [MapperIgnoreSource(nameof(DestinationImage.DestinationId))]
        [MapperIgnoreSource(nameof(DestinationImage.AdminId))]
        [MapperIgnoreSource(nameof(DestinationImage.UploadedAt))]
        public partial DestinationImageInsertDto DestinationImageToDestinationImageInsertDto(DestinationImage model);

        [MapperIgnoreTarget(nameof(Activity.ActivityId))]
        [MapperIgnoreTarget(nameof(Activity.DestinationId))]
        [MapperIgnoreTarget(nameof(Activity.AdminId))]
        public partial Activity ActivityInsertDtoToActivity(ActivityInsertDto dto);

        [MapperIgnoreSource(nameof(Activity.ActivityId))]
        [MapperIgnoreSource(nameof(Activity.DestinationId))]
        [MapperIgnoreSource(nameof(Activity.AdminId))]
        public partial ActivityInsertDto ActivityToActivityInsertDto(Activity model);

        [MapperIgnoreTarget(nameof(Favorite.UserId))]
        [MapperIgnoreTarget(nameof(Favorite.DestinationId))]
        [MapperIgnoreSource(nameof(FavoriteDto.Destination))]
        public partial Favorite FavoriteDtoToFavorite(FavoriteDto dto);

        [MapperIgnoreSource(nameof(Favorite.UserId))]
        [MapperIgnoreSource(nameof(Favorite.DestinationId))]
        [MapperIgnoreTarget(nameof(FavoriteDto.Destination))]
        public partial FavoriteDto FavoriteToFavoriteDto(Favorite model);
    }
}
